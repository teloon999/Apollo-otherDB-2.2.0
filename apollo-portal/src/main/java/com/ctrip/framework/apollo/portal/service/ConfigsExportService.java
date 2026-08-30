/*
 * Copyright 2023 Apollo Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
package com.ctrip.framework.apollo.portal.service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import com.ctrip.framework.apollo.common.dto.ClusterDTO;
import com.ctrip.framework.apollo.common.entity.App;
import com.ctrip.framework.apollo.common.entity.AppNamespace;
import com.ctrip.framework.apollo.common.exception.BadRequestException;
import com.ctrip.framework.apollo.common.exception.ServiceException;
import com.ctrip.framework.apollo.core.enums.ConfigFileFormat;
import com.ctrip.framework.apollo.portal.component.PermissionValidator;
import com.ctrip.framework.apollo.portal.component.PortalSettings;
import com.ctrip.framework.apollo.portal.entity.bo.ConfigBO;
import com.ctrip.framework.apollo.portal.entity.bo.NamespaceBO;
import com.ctrip.framework.apollo.portal.environment.Env;
import com.ctrip.framework.apollo.portal.util.ConfigFileUtils;
import com.ctrip.framework.apollo.portal.util.NamespaceBOUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Consumer;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
public class ConfigsExportService {

  private static final Logger logger = LoggerFactory.getLogger(ConfigsExportService.class);

  // use a fixed, locale-independent date format so that exported files can be
  // imported on JVMs with any locale/JDK version
  private final Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").create();

  private final AppService appService;

  private final ClusterService clusterService;

  private final NamespaceService namespaceService;

  private final AppNamespaceService appNamespaceService;

  private final PortalSettings portalSettings;

  private final PermissionValidator permissionValidator;

  public ConfigsExportService(
      AppService appService,
      ClusterService clusterService,
      final @Lazy NamespaceService namespaceService,
      final AppNamespaceService appNamespaceService,
      PortalSettings portalSettings,
      PermissionValidator permissionValidator) {
    this.appService = appService;
    this.clusterService = clusterService;
    this.namespaceService = namespaceService;
    this.appNamespaceService = appNamespaceService;
    this.portalSettings = portalSettings;
    this.permissionValidator = permissionValidator;
  }

  /**
   * Export all application which current user own them.
   * <p>
   * File Struts:
   * <p>
   *
   * List<AppNamespaceMetadata>
   * List<ownerName> -> List<App> -> List<Env> -> List<Namespace>
   * -----------------> app.metadata
   * -------------------------------------------> List<cluster.metadata>
   *
   * @param outputStream network file download stream to user
   */
  public void exportData(OutputStream outputStream, List<Env> exportEnvs) {
    if (CollectionUtils.isEmpty(exportEnvs)) {
      exportEnvs = portalSettings.getActiveEnvs();
    }

    exportApps(exportEnvs, outputStream);
  }

  public static final String APP_EXPORT_MANIFEST_FILENAME = "export.manifest.json";

  /**
   * Export one app: the app metadata, its own app namespaces, clusters and namespace configs of the
   * given envs. When {@code includeLinked} is true, the associated public namespace instances which
   * the current user can read are exported as well.
   * <p>
   * The zip structure is fully compatible with {@link ConfigsImportService#importDataFromZipFile},
   * so the exported package can be imported by the existing import entrance. A manifest file
   * ({@link #APP_EXPORT_MANIFEST_FILENAME}) is written to the zip root to record linked public
   * namespaces which are skipped (no read permission / not exported) or not created in some env.
   * The manifest is ignored by the import logic.
   */
  public void exportApp(String appId, List<Env> exportEnvs, boolean includeLinked, OutputStream outputStream) {
    if (CollectionUtils.isEmpty(exportEnvs)) {
      throw new BadRequestException("export envs is empty");
    }

    final App app = appService.load(appId);
    if (app == null) {
      throw new BadRequestException("app not found. appId = " + appId);
    }

    final List<Env> activeEnvs = portalSettings.getActiveEnvs();
    for (Env env : exportEnvs) {
      if (!activeEnvs.contains(env)) {
        throw new BadRequestException("env is not active. env = " + env);
      }
    }

    // manifest data
    final Map<String, List<Map<String, Object>>> linkedNamespacesByEnv = new LinkedHashMap<>();
    final List<Map<String, String>> missingLinkedNamespaces = new ArrayList<>();
    final Map<String, Set<String>> linkedNamesByEnv = new LinkedHashMap<>();
    final Set<String> exportedLinkedNamespaceNames = new LinkedHashSet<>();

    try (final ZipOutputStream zipOutputStream = new ZipOutputStream(outputStream)) {
      // app metadata
      writeToZip(ConfigFileUtils.genAppInfoPath(app), gson.toJson(app), zipOutputStream);

      // the app's own app namespace definitions
      final List<AppNamespace> ownAppNamespaces = appNamespaceService.findByAppId(appId);
      for (AppNamespace appNamespace : ownAppNamespaces) {
        writeToZip(ConfigFileUtils.genAppNamespaceInfoPath(appNamespace), gson.toJson(appNamespace), zipOutputStream);
      }

      // clusters and namespace configs per env
      for (Env env : exportEnvs) {
        final List<ClusterDTO> clusters;
        try {
          clusters = clusterService.findClusters(env, appId);
        } catch (Exception e) {
          logger.warn("load clusters failed. appId = {}, env = {}", appId, env, e);
          continue;
        }
        if (CollectionUtils.isEmpty(clusters)) {
          continue;
        }

        for (ClusterDTO cluster : clusters) {
          writeToZip(ConfigFileUtils.genClusterInfoPath(app, env, cluster), gson.toJson(cluster), zipOutputStream);

          final List<NamespaceBO> namespaceBOs;
          try {
            namespaceBOs = namespaceService.findNamespaceBOs(appId, env, cluster.getName(), false);
          } catch (BadRequestException e) {
            // cluster has no namespace
            continue;
          } catch (Exception e) {
            logger.error("load namespaces failed. appId = {}, env = {}, cluster = {}", appId, env,
                cluster.getName(), e);
            continue;
          }

          for (NamespaceBO namespaceBO : namespaceBOs) {
            final String namespaceName = namespaceBO.getBaseInfo().getNamespaceName();

            if (!isLinkedNamespace(namespaceBO, appId)) {
              // the app's own namespace, always export
              writeNamespaceConfig(app, env, cluster.getName(), namespaceBO, zipOutputStream);
              continue;
            }

            // linked public namespace
            linkedNamesByEnv.computeIfAbsent(env.getName(), k -> new LinkedHashSet<>()).add(namespaceName);

            final Map<String, Object> linkedRecord = new LinkedHashMap<>();
            linkedRecord.put("namespace", namespaceName);
            if (!includeLinked) {
              linkedRecord.put("exported", false);
              linkedRecord.put("reason", "includeLinkedNamespaces is disabled");
            } else if (permissionValidator.shouldHideConfigToCurrentUser(appId, env.getName(), namespaceName)) {
              // no read permission on the public namespace, skip to avoid permission leak
              linkedRecord.put("exported", false);
              linkedRecord.put("reason", "no read permission");
            } else {
              linkedRecord.put("exported", true);
              exportedLinkedNamespaceNames.add(namespaceName);
              writeNamespaceConfig(app, env, cluster.getName(), namespaceBO, zipOutputStream);
            }
            linkedNamespacesByEnv.computeIfAbsent(env.getName(), k -> new ArrayList<>()).add(linkedRecord);
          }
        }
      }

      // linked public namespace definitions, so that import can recreate the association
      for (String namespaceName : exportedLinkedNamespaceNames) {
        final AppNamespace publicAppNamespace = appNamespaceService.findPublicAppNamespace(namespaceName);
        if (publicAppNamespace != null) {
          writeToZip(ConfigFileUtils.genAppNamespaceInfoPath(publicAppNamespace), gson.toJson(publicAppNamespace),
              zipOutputStream);
        }
      }

      // linked in some env but not created/associated in another export env
      final Set<String> allLinkedNames = new LinkedHashSet<>();
      linkedNamesByEnv.values().forEach(allLinkedNames::addAll);
      for (Env env : exportEnvs) {
        final Set<String> namesInEnv = linkedNamesByEnv.getOrDefault(env.getName(), Collections.emptySet());
        for (String namespaceName : allLinkedNames) {
          if (!namesInEnv.contains(namespaceName)) {
            final Map<String, String> missing = new LinkedHashMap<>();
            missing.put("env", env.getName());
            missing.put("namespace", namespaceName);
            missing.put("reason", "not created or associated in this env");
            missingLinkedNamespaces.add(missing);
          }
        }
      }

      // manifest
      final Map<String, Object> manifest = new LinkedHashMap<>();
      manifest.put("exportType", "app");
      manifest.put("appId", appId);
      manifest.put("exportTime", new Date());
      manifest.put("envs", exportEnvs.stream().map(Env::getName).collect(Collectors.toList()));
      manifest.put("includeLinkedNamespaces", includeLinked);
      manifest.put("linkedNamespaces", linkedNamespacesByEnv);
      manifest.put("missingLinkedNamespaces", missingLinkedNamespaces);
      writeToZip(APP_EXPORT_MANIFEST_FILENAME, gson.toJson(manifest), zipOutputStream);
    } catch (IOException e) {
      logger.error("export app config error. appId = {}", appId, e);
      throw new ServiceException("export app config error", e);
    }
  }

  /**
   * a linked namespace is a public namespace instance whose definition belongs to another app.
   */
  private boolean isLinkedNamespace(NamespaceBO namespaceBO, String appId) {
    return namespaceBO.isPublic() && !appId.equals(namespaceBO.getParentAppId());
  }

  private void writeNamespaceConfig(App app, Env env, String clusterName, NamespaceBO namespaceBO,
                                    ZipOutputStream zipOutputStream) throws IOException {
    final String appId = app.getAppId();
    final String namespaceName = namespaceBO.getBaseInfo().getNamespaceName();
    final ConfigFileFormat format = ConfigFileFormat.fromString(namespaceBO.getFormat());

    final String configFileName = ConfigFileUtils.toFilename(appId, clusterName, namespaceName, format);
    final String filePath = ConfigFileUtils.genNamespacePath(app.getOwnerName(), appId, env, configFileName);

    writeToZip(filePath, NamespaceBOUtils.convert2configFileContent(namespaceBO), zipOutputStream);
  }

  private void exportApps(final Collection<Env> exportEnvs, OutputStream outputStream) {
    List<App> hasPermissionApps = findHasPermissionApps();

    if (CollectionUtils.isEmpty(hasPermissionApps)) {
      return;
    }

    try (final ZipOutputStream zipOutputStream = new ZipOutputStream(outputStream)) {
      //write app info to zip
      writeAppInfoToZip(hasPermissionApps, zipOutputStream);

      //export app namespace
      exportAppNamespaces(zipOutputStream);

      //export app's clusters
      exportEnvs.parallelStream().forEach(env -> {
        try {
          this.exportClusters(env, hasPermissionApps, zipOutputStream);
        } catch (Exception e) {
          logger.error("export cluster error. env = {}", env, e);
        }
      });
    } catch (IOException e) {
      logger.error("export config error", e);
      throw new ServiceException("export config error", e);
    }
  }

  private List<App> findHasPermissionApps() {
    // get all apps
    final List<App> apps = appService.findAll();

    if (CollectionUtils.isEmpty(apps)) {
      return Collections.emptyList();
    }

    // permission check
    final Predicate<App> isAppAdmin =
        app -> {
          try {
            return permissionValidator.isAppAdmin(app.getAppId());
          } catch (Exception e) {
            logger.error("permission check failed. app = {}", app);
            return false;
          }
        };

    // app admin permission filter
    return apps.stream().filter(isAppAdmin).collect(Collectors.toList());
  }

  private void writeAppInfoToZip(List<App> apps, ZipOutputStream zipOutputStream) {
    logger.info("to import app size = {}", apps.size());

    final Consumer<App> appConsumer =
        app -> {
          try {
            synchronized (zipOutputStream) {
              String fileName = ConfigFileUtils.genAppInfoPath(app);
              String content = gson.toJson(app);

              writeToZip(fileName, content, zipOutputStream);
            }
          } catch (IOException e) {
            logger.error("Write error. {}", app);
            throw new ServiceException("Write app error. {}", e);
          }
        };

    apps.forEach(appConsumer);
  }

  private void exportAppNamespaces(ZipOutputStream zipOutputStream) {
    List<AppNamespace> appNamespaces = appNamespaceService.findAll();

    logger.info("to import appnamespace size = " + appNamespaces.size());

    Consumer<AppNamespace> appNamespaceConsumer = appNamespace -> {
      try {
        synchronized (zipOutputStream) {
          String fileName = ConfigFileUtils.genAppNamespaceInfoPath(appNamespace);
          String content = gson.toJson(appNamespace);

          writeToZip(fileName, content, zipOutputStream);
        }
      } catch (Exception e) {
        logger.error("Write appnamespace error. {}", appNamespace);
        throw new IllegalStateException(e);
      }
    };

    appNamespaces.forEach(appNamespaceConsumer);

  }

  private void exportClusters(final Env env, final List<App> exportApps, ZipOutputStream zipOutputStream) {
    exportApps.parallelStream().forEach(exportApp -> {
      try {
        this.exportCluster(env, exportApp, zipOutputStream);
      } catch (Exception e) {
        logger.error("export cluster error. appId = {}", exportApp.getAppId(), e);
      }
    });
  }

  private void exportCluster(final Env env, final App exportApp, ZipOutputStream zipOutputStream) {
    final List<ClusterDTO> exportClusters = clusterService.findClusters(env, exportApp.getAppId());

    if (CollectionUtils.isEmpty(exportClusters)) {
      return;
    }

    //write cluster info to zip
    writeClusterInfoToZip(env, exportApp, exportClusters, zipOutputStream);

    //export namespaces
    exportClusters.parallelStream().forEach(cluster -> {
      try {
        this.exportNamespaces(env, exportApp, cluster, zipOutputStream);
      } catch (BadRequestException badRequestException) {
        //ignore
      } catch (Exception e) {
        logger.error("export namespace error. appId = {}, cluster = {}", exportApp.getAppId(), cluster, e);
      }
    });
  }

  private void exportNamespaces(final Env env, final App exportApp, final ClusterDTO exportCluster,
                                ZipOutputStream zipOutputStream) {
    String clusterName = exportCluster.getName();

    List<NamespaceBO> namespaceBOS = namespaceService.findNamespaceBOs(exportApp.getAppId(), env, clusterName, false);

    if (CollectionUtils.isEmpty(namespaceBOS)) {
      return;
    }

    Stream<ConfigBO> configBOStream = namespaceBOS.stream()
        .map(
            namespaceBO -> new ConfigBO(env, exportApp.getOwnerName(), exportApp.getAppId(), clusterName, namespaceBO));

    writeNamespacesToZip(configBOStream, zipOutputStream);
  }

  private void writeNamespacesToZip(Stream<ConfigBO> configBOStream, ZipOutputStream zipOutputStream) {
    final Consumer<ConfigBO> configBOConsumer =
        configBO -> {
          try {
            synchronized (zipOutputStream) {
              String appId = configBO.getAppId();
              String clusterName = configBO.getClusterName();
              String namespace = configBO.getNamespace();
              String configFileContent = configBO.getConfigFileContent();
              ConfigFileFormat configFileFormat = configBO.getFormat();

              String
                  configFileName =
                  ConfigFileUtils.toFilename(appId, clusterName, namespace, configFileFormat);
              String filePath =
                  ConfigFileUtils.genNamespacePath(configBO.getOwnerName(), appId, configBO.getEnv(), configFileName);

              writeToZip(filePath, configFileContent, zipOutputStream);
            }
          } catch (IOException e) {
            logger.error("Write error. {}", configBO);
            throw new ServiceException("Write namespace error. {}", e);
          }
        };

    configBOStream.forEach(configBOConsumer);
  }

  private void writeClusterInfoToZip(Env env, App app, List<ClusterDTO> exportClusters,
                                     ZipOutputStream zipOutputStream) {
    final Consumer<ClusterDTO> clusterConsumer =
        cluster -> {
          try {
            synchronized (zipOutputStream) {
              String fileName = ConfigFileUtils.genClusterInfoPath(app, env, cluster);
              String content = gson.toJson(cluster);

              writeToZip(fileName, content, zipOutputStream);
            }
          } catch (IOException e) {
            logger.error("Write error. {}", cluster);
            throw new ServiceException("Write error. {}", e);
          }
        };

    exportClusters.forEach(clusterConsumer);
  }

  private void writeToZip(String filePath, String content, ZipOutputStream zipOutputStream)
      throws IOException {
    final ZipEntry zipEntry = new ZipEntry(filePath);
    try {
      zipOutputStream.putNextEntry(zipEntry);
      zipOutputStream.write(content.getBytes());
      zipOutputStream.closeEntry();
    } catch (IOException e) {
      String errorMsg = "write content to zip error. file = " + filePath + ", content = " + content;
      logger.error(errorMsg);
      throw new IOException(errorMsg, e);
    }
  }

}
