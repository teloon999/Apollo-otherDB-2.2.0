rem
rem Copyright 2023 Apollo Authors
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem
rem Apollo 统一构建脚本（Windows）
rem
rem 本工程将 MySQL / PostgreSQL / 达梦(DM8) / 人大金仓(PG模式) 的 JDBC 驱动
rem 全部打入同一个可执行 jar，一次构建即可运行期任意切换数据库，无需按库分包。
rem 切换发生在运行期（改配置后重启），参见 README-Database-Switching.md 第六节。
rem 仅当切换到达梦时，构建前需先执行一次：scripts\install-dm-driver.bat
@echo off
setlocal

rem go to script directory
cd "%~dp0"

cd ..

echo ==== building config-service and admin-service ====
call mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github

echo ==== building portal ====
rem portal 需激活 auth 认证 Profile，否则会进入“默认免认证”(固定用户 apollo、无法退出)模式
call mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth

echo ==== build finished ====
echo The produced jars support switching between MySQL / PostgreSQL / Dameng / Kingbase at RUNTIME.
echo See README-Database-Switching.md for how to switch.

endlocal
pause