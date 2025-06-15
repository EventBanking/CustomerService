#!/bin/bash

set -e

# Fail fast if password isn't set
if [[ -z "$MSSQL_SA_PASSWORD" ]]; then
  echo "❌ MSSQL_SA_PASSWORD is not set. Exiting..."
  exit 1
fi

SA_PASSWORD="$MSSQL_SA_PASSWORD"
SQLCMD="/opt/mssql-tools/bin/sqlcmd"
SQLSERVER="/opt/mssql/bin/sqlservr"

echo "🚀 Starting SQL Server in background..."
$SQLSERVER > /var/log/sqlserver.log 2>&1 &

RETRIES=60
WAIT_SECONDS=2
READY_MESSAGE="SQL Server is now ready for client connections"

echo "⏳ Waiting for SQL Server to report readiness..."

for i in $(seq 1 $RETRIES); do
  if grep -q "$READY_MESSAGE" /var/log/sqlserver.log; then
    echo "✅ SQL Server is ready!"
    break
  fi
  echo "⏳ Not ready yet... ($i/$RETRIES)"
  sleep $WAIT_SECONDS
done

if [ "$i" -eq "$RETRIES" ]; then
  echo "❌ SQL Server log did not show readiness message in time."
  tail -n 100 /var/log/sqlserver.log
  exit 1
fi

echo "📄 Running init-db.sql..."
$SQLCMD -S localhost -U sa -P "$SA_PASSWORD" -i /usr/src/app/init-db.sql

echo "✅ Initialization complete. Bringing SQL Server to foreground..."
wait
