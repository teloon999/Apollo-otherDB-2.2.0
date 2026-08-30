@echo off
REM Install the Dameng (DM8) JDBC driver (DmJdbcDriver8.jar) to the local
REM Maven repository. This MUST be done once before building the project,
REM because the driver is NOT available on public Maven repositories and is
REM referenced by apollo-common as a non-system dependency.
REM
REM Run from the project root:
REM   scripts\install-dm-driver.bat

setlocal
if not exist "DmJdbcDriver8.jar" (
  echo ERROR: DmJdbcDriver8.jar not found in the current directory.
  echo Please run this script from the project root.
  exit /b 1
)

echo ==== Installing DmJdbcDriver8.jar to local Maven repository ====
call mvn install:install-file -Dfile=DmJdbcDriver8.jar -DgroupId=com.dameng -DartifactId=DmJdbcDriver8 -Dversion=8 -Dpackaging=jar
if errorlevel 1 (
  echo ==== FAILED to install Dameng JDBC driver ====
  exit /b 1
)
echo ==== Dameng JDBC driver installed successfully ====
endlocal