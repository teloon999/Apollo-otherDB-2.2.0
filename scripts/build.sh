#!/bin/sh
#
# Copyright 2023 Apollo Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# =====================================================================
# Apollo 统一构建脚本
#
# 本工程将 MySQL / PostgreSQL / 达梦(DM8) / 人大金仓(PG模式) 的 JDBC 驱动
# 全部打入同一个可执行 jar，因此：「一次构建，即可运行期任意切换数据库」，
# 无需按数据库构建不同版本。
#
# 数据库切换发生在「运行期」（改配置后重启生效），与本次构建无关，参见：
#   README-Database-Switching.md 第六节
#
# 运行期切换（三选一改 SPRING_PROFILES_ACTIVE + 注入连接即可）：
#   PostgreSQL : SPRING_PROFILES_ACTIVE=github,postgre  URL=jdbc:postgresql://...
#   达梦 DM8   : SPRING_PROFILES_ACTIVE=github,dm        URL=jdbc:dm://...?SCHEMA=APOLLOCONFIGDB
#   人大金仓   : SPRING_PROFILES_ACTIVE=github,kingbase  URL=jdbc:postgresql://...（PG 模式）
#   MySQL      : SPRING_PROFILES_ACTIVE=github,mysql     URL=jdbc:mysql://...
#   连接用户名/密码通过 SPRING_DATASOURCE_USERNAME / SPRING_DATASOURCE_PASSWORD 注入。
#
# 说明：仅当切换到达梦时，构建前需先安装一次达梦驱动（本仓库其它库无需）：
#   sh scripts/install-dm-driver.sh
# =====================================================================

# go to script directory
cd "${0%/*}" || exit

cd ..

echo "==== building config-service and admin-service ===="
mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github

echo "==== building portal ===="
# portal 需激活 auth 认证 Profile，否则会进入“默认免认证”(固定用户 apollo、无法退出)模式
mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth

echo "==== build finished ===="
echo "The produced jars support switching between MySQL / PostgreSQL / Dameng / Kingbase at RUNTIME."
echo "See README-Database-Switching.md (section 6) for how to switch."