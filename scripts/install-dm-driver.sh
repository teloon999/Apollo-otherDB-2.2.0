#!/bin/sh
#
# Install the Dameng (DM8) JDBC driver (DmJdbcDriver8.jar) to the local
# Maven repository. This MUST be done once before building the project,
# because the driver is NOT available on public Maven repositories and is
# referenced by apollo-common as a non-system dependency.
#
# Run from the project root:
#   sh scripts/install-dm-driver.sh
#
set -e

MVN=${MVN:-mvn}
JAR="DmJdbcDriver8.jar"

if [ ! -f "$JAR" ]; then
  echo "ERROR: $JAR not found in the current directory." >&2
  echo "Please run this script from the project root, or set the dir containing $JAR." >&2
  exit 1
fi

echo "==== Installing $JAR to local Maven repository ===="
"$MVN" install:install-file \
  -Dfile="$JAR" \
  -DgroupId=com.dameng \
  -DartifactId=DmJdbcDriver8 \
  -Dversion=8 \
  -Dpackaging=jar
echo "==== Dameng JDBC driver installed successfully ===="