# Apollo 多数据库动态切换说明（达梦 / PostgreSQL / 人大金仓 PG 模式 / MySQL / H2）

本工程为 Apache Apollo 2.2.0 的统一多数据库改造版，将原先针对 **达梦（DM8）**、
**PostgreSQL**、**人大金仓（KingbaseES，PG 模式）** 的独立改造整合为同一份工程。
服务通过**修改配置文件**即可动态切换所连接的数据库，**切换后重启生效**。
同时保留了对 MySQL 与 H2 的支持。

---

## 一、支持的数据库与对应 Profile

| 数据库 | Profile 名称 | JDBC 驱动 | 说明 |
| ------ | ------------ | --------- | ---- |
| MySQL | `mysql`（默认） | `com.mysql.cj.jdbc.Driver` | Apollo 原生支持，默认可用 |
| H2 | `h2` | 内置 | 多用于本地开发/测试 |
| PostgreSQL | `postgre` | `org.postgresql.Driver` | Hibernate 依据 URL 自动识别 PG 方言 |
| 达梦 DM8 | `dm` | `dm.jdbc.driver.DmDriver` | 需显式指定方言 `DamengDialect`；驱动需手动安装到本地 Maven 仓库 |
| 人大金仓（PG 模式） | `kingbase` | `org.postgresql.Driver` | 金仓 PG 模式与 PG 高度兼容，复用 PG 驱动 |

> Profile 配置文件位于 `apollo-common/src/main/resources/`：
> `application-mysql.properties` / `application-h2.properties` /
> `application-postgre.properties` / `application-dm.properties` / `application-kingbase.properties`。
> 因 `apollo-common` 被所有服务依赖，这些库型配置对三个服务（configservice、adminservice、portal）全局生效。

---

## 二、项目结构说明

```
Apollo-otherDB-2.2.0-unified/
├── pom.xml                                  # 根工程，定义三库驱动依赖与版本
├── DmJdbcDriver8.jar                        # 达梦驱动（二进制，用于 install-file）
├── apollo-common/                            # 公共模块：方言类 + 各库 Profile 配置
│   └── src/main/java/.../common/jpa/
│       ├── DamengDialect.java                # 达梦 Hibernate 方言
│       ├── DamengIdentityColumnSupport.java  # 达梦 IDENTITY 列支持
│       └── DamengGetGeneratedKeysDelegate.java # 达梦主键回取
├── apollo-configservice/                     # ConfigService（连接 ApolloConfigDB）
├── apollo-adminservice/                      # AdminService（连接 ApolloConfigDB）
├── apollo-portal/                            # Portal（连接 ApolloPortalDB）
├── apollo-assembly/                          # 打包聚合（可产出独立可执行 jar）
└── scripts/
    ├── install-dm-driver.sh / .bat           # 达梦驱动安装到本地 Maven 仓库
    └── sql/
        ├── Dameng/   apolloconfigdb.sql + apolloportaldb.sql   # 达梦建库脚本
        ├── Postgresql/apolloconfigdb.sql + apolloportaldb.sql  # PostgreSQL 建库脚本
        ├── Kingbase/ apolloconfigdb.sql + apolloportaldb.sql   # 人大金仓建库脚本
        └── MySQL/    apolloconfigdb.sql + apolloportaldb.sql   # MySQL 建库脚本
```

三个服务的数据库区分：**configservice / adminservice 使用 ApolloConfigDB**，
**portal 使用 ApolloPortalDB**。各服务通过自己的 `SPRING_DATASOURCE_URL` 指向对应库。

---

## 三、核心机制

1. **Spring Profile 选库型**：通过激活对应 database profile（`mysql` / `postgre` / `dm` / `kingbase` / `h2`），
   加载对应库型的方言/驱动/微调配置。
2. **连接信息注入**：连接地址 / 用户名 / 密码通过环境变量注入：
   - `SPRING_DATASOURCE_URL`
   - `SPRING_DATASOURCE_USERNAME`
   - `SPRING_DATASOURCE_PASSWORD`
   这是 Apollo 既有的接入机制，兼容原 postgres 版的部署方式。
3. **切换即改配置**：修改 Profile 与连接环境变量 → **重启服务**生效。

---

## 四、数据库初始化（建库脚本）

按所选数据库，在对应库中执行初始化 SQL（注意先建 `ApolloConfigDB` / `ApolloPortalDB`）：

| 数据库 | 脚本目录 | 说明 |
| ------ | -------- | ---- |
| MySQL | `scripts/sql/MySQL/` | 标准 MySQL（utf8mb4）建库脚本 |
| PostgreSQL | `scripts/sql/Postgresql/` | PostgreSQL dump |
| 人大金仓 | `scripts/sql/Kingbase/` | KingbaseES PG 模式 dump |
| 达梦 DM8 | `scripts/sql/Dameng/` | 达梦专用建库脚本（含达梦特有的建表语法） |

每类目录下统一命名：
- `apolloconfigdb.sql` —— ApolloConfigDB
- `apolloportaldb.sql` —— ApolloPortalDB

---

## 五、达梦驱动安装（首次构建前必做一次）

达梦驱动 `DmJdbcDriver8.jar` 不在公共 Maven 仓库中，工程以普通依赖引用
（`com.dameng:DmJdbcDriver8:8`），因此**构建前需先将其安装到本地 Maven 仓库**。

Linux / macOS：

```bash
sh scripts/install-dm-driver.sh
```

Windows：

```bat
scripts\install-dm-driver.bat
```

等价命令：

```bash
mvn install:install-file -Dfile=DmJdbcDriver8.jar -DgroupId=com.dameng -DartifactId=DmJdbcDriver8 -Dversion=8 -Dpackaging=jar
```

> 即便当前只使用 Postgre/Kingbase/MySQL，也建议执行一次，保证编译期可解析所有依赖。

---

## 六、切换数据库示例

以下示例通过启动时注入 Profile 与连接环境变量完成切换，**均需重启服务生效**。

### 6.1 PostgreSQL

```bash
export SPRING_PROFILES_ACTIVE=github,postgre
export SPRING_DATASOURCE_URL=jdbc:postgresql://192.168.1.10:5432/configdb
export SPRING_DATASOURCE_USERNAME=apollo
export SPRING_DATASOURCE_PASSWORD=pass
```

对应 portal 服务则把 URL 指向 `portaldb`。

### 6.2 达梦 DM8

```bash
export SPRING_PROFILES_ACTIVE=github,dm
export SPRING_DATASOURCE_URL="jdbc:dm://192.168.1.11:5236?SCHEMA=APOLLOCONFIGDB"
export SPRING_DATASOURCE_USERNAME=SYSDBA
export SPRING_DATASOURCE_PASSWORD=pass
```

达梦的 URL 建议显式指定 `SCHEMA`（如 `APOLLOCONFIGDB` / `APOLLOPORTALDB`），
服务会自动加载 `DamengDialect` 等达梦方言处理分页、IDENTITY 列与主键回取差异。

### 6.3 人大金仓（PG 模式）

```bash
export SPRING_PROFILES_ACTIVE=github,kingbase
export SPRING_DATASOURCE_URL=jdbc:postgresql://192.168.1.12:54321/configdb
export SPRING_DATASOURCE_USERNAME=kingbase
export SPRING_DATASOURCE_PASSWORD=pass
```

金仓 PG 模式直接复用 PG 驱动，Hibernate 自动识别 PG 方言，无需额外方言配置。

### 6.4 MySQL（默认）

```bash
export SPRING_PROFILES_ACTIVE=github,mysql
export SPRING_DATASOURCE_URL=jdbc:mysql://192.168.1.13:3306/ApolloConfigDB?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
export SPRING_DATASOURCE_USERNAME=apollo
export SPRING_DATASOURCE_PASSWORD=pass
```

### 6.5 直接修改配置文件方式

若不使用环境变量，也可直接在对应服务的 `application.properties` 中激活 Profile
（连接信息仍建议通过环境变量注入，避免把密码写进仓库视图）：

```properties
# 例如 apollo-adminservice/src/main/resources/application.properties
spring.profiles.active=github,postgre
```

### 6.6 Portal 登录认证（必须激活 `auth` Profile）

需要澄清：**任何数据库组合都不会自动开启登录**。Apollo Portal 只有在激活
`auth`（或 `ldap`/`oidc`）Profile 时才启用真实登录；否则进入**默认免认证模式**，
当前用户被固定为 `apollo`、无法退出。因此 Portal 的激活 Profile 必须加上 `auth`：

```bash
export SPRING_PROFILES_ACTIVE=github,postgre,auth   # postgre 可换成 dm / kingbase / mysql
```

- 登录账号来源于 ApolloPortalDB 的 `Users` / `Authorities` 表，默认账号为 **apollo / admin**。
- ConfigService / AdminService 无需 `auth`，只有 Portal 需要。
- Docker 部署时对应 `SPRING_PROFILES_ACTIVE=github,<DB>,auth`。

---

## 七、构建与打包

整体打包（含三个服务）：

```bash
# 若未安装达梦驱动，先执行：sh scripts/install-dm-driver.sh
mvn clean package -DskipTests
```

或者用统一构建脚本：

```bash
sh scripts/build.sh      # Linux / macOS
scripts\build.bat        # Windows
```

> **重要**：本工程将四类数据库驱动全部打入**同一个可执行 jar**，一次构建即可在运行期
> 任意切换数据库（改配置 + 重启），**不需要**按数据库构建不同版本。
> 切库方式见本文第六节，构建产物与所选数据库无关。

针对单一服务：

```bash
mvn clean package -DskipTests -pl apollo-configservice -am
mvn clean package -DskipTests -pl apollo-adminservice -am
mvn clean package -DskipTests -pl apollo-portal -am
```

> 三种数据库驱动均被打入每个服务的可执行 jar 中，**同一份构建产物即可支持三库**，
> 运行时仅需通过 Profile + 连接环境变量选择库型。

---

## 八、Docker 部署

各服务已自带 `Dockerfile`（模块根目录 `apollo-adminservice/Dockerfile` 等）。
镜像内已包含全部驱动，通过环境变量指定库型即可切换。示例（PostgreSQL）：

```bash
docker run -d \
  -e SPRING_PROFILES_ACTIVE=github,postgre \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://<PG地址>:5432/configdb \
  -e SPRING_DATASOURCE_USERNAME=<用户> \
  -e SPRING_DATASOURCE_PASSWORD=<密码> \
  -e APOLLO_RUN_MODE=Docker \
  -p 8080:8080 \
  apollo-configservice-<version>
```

对应三服务端口：
- `apollo-configservice`：8080
- `apollo-adminservice`：8090
- `apollo-portal`：8070

切换为达梦时，仅需将上述 `SPRING_PROFILES_ACTIVE` 改为 `github,dm` 并把
`SPRING_DATASOURCE_URL` 改为 `jdbc:dm://...`；金仓改为 `github,kingbase`。

> 三服务一键部署示例及切换模板见 `deploy/docker/docker-compose.example.yaml` 与
> `deploy/docker/.env.example`：仅修改 `.env` 中的 `APOLLO_DB_PROFILE` 与连接串即可切换库型。
> K8s 部署见 `deploy/k8s/configmap.yaml` 与 `deploy/k8s/apollo-2.2.0.yaml`（命名空间 `apollo`，
> 改 ConfigMap 即可切库，DB 密码建议改用 Secret）。

---

## 九、达梦特殊适配说明

达梦（DM8）与标准 JPA 存在若干差异，本工程已通过 `apollo-common` 中三个类适配：

| 类 | 作用 |
| -- | -- |
| `DamengDialect` | 继承 Oracle12c 方言，分页使用 SQL 标准的 `OFFSET..FETCH NEXT..ROWS ONLY` |
| `DamengIdentityColumnSupport` | DM8 不允许对 IDENTITY 列显式传 `DEFAULT`，INSERT 时省略该列 |
| `DamengGetGeneratedKeysDelegate` | DM8 的 `getGeneratedKeys()` 列标签与实体列名不一致，按列索引回取主键 |

这三个类仅由 `dm` Profile 的 `spring.jpa.database-platform` 引用，
启用 Postgre / Kingbase / MySQL 时不会被加载，互不影响。

---

## 十、常见问题

- **切换库后服务无法启动 / 连接拒绝**：检查对应 Profile 是否正确激活，以及
  `SPRING_DATASOURCE_URL/USERNAME/PASSWORD` 是否指向正确数据库实例。
- **达梦报“无效的列” / 主键回取失败**：确认已使用 `dm` Profile（加载 `DamengDialect`）。
- **Maven 构建找不到 `com.dameng`**：先执行 `scripts/install-dm-driver.sh` 安装驱动。
- **金仓连接报错**：请确认使用 PG 模式且连接串为 `jdbc:postgresql://...`；若金仓实例需使用
  金仓官方驱动（`jdbc:kingbase8://`），请联系维护者扩展 `application-kingbase.properties`。