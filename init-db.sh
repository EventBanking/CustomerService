#!/usr/bin/env bash
set -e

DB_NAME="EventBankingCo_CustomerService_Test"
SQL_USER="sa"
SQL_PASSWORD="3v3nTp@sSw0rD"
DACPAC_PATH="./dacpac/EventBankingCo.CustomerService.Database.dacpac"

# Wait for SQL Server to become available
echo "Waiting for SQL Server to be ready..."
for i in {1..30}; do
  if docker exec sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U $SQL_USER -P $SQL_PASSWORD -Q "SELECT 1" &> /dev/null; then
    echo "✅ SQL Server is ready."
    break
  fi
  echo "⏳ Waiting for SQL Server... ($i)"
  sleep 5
done

# Deploy DACPAC
echo "🚀 Deploying DACPAC..."
docker exec sqlserver /bin/bash -c "
  curl -LO https://aka.ms/sqlpackage-linux &&
  unzip -o sqlpackage-linux -d sqlpackage &&
  chmod +x sqlpackage/sqlpackage &&
  ./sqlpackage/sqlpackage /Action:Publish \
   /SourceFile:/var/opt/mssql/dacpac/EventBankingCo.CustomerService.Database.dacpac \
   /TargetConnectionString:'Server=localhost;User Id=sa;Password=3v3nTp@sSw0rD;TrustServerCertificate=True;' \
   /p:BlockOnPossibleDataLoss=false \
   /p:CreateNewDatabase=true \
   /TargetDatabaseName:"$DB_NAME"

