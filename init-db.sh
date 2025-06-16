#!/bin/bash
set -euo pipefail

apt-get update && \
apt-get install -y unzip curl libicu-dev

curl -LO https://aka.ms/sqlpackage-linux
unzip sqlpackage-linux -d /sqlpackage
chmod +x /sqlpackage/sqlpackage
ln -s /sqlpackage/sqlpackage /usr/local/bin/sqlpackage

echo "🔄 Waiting for SQL Server at $SQL_SERVER..."

for i in {1..30}; do
  sqlpackage /Action:Publish \
    /SourceFile:/dacpac/EventBankingCo.CustomerService.Database.dacpac \
    /TargetConnectionString:"Server=$SQL_SERVER;Database=$DB_NAME;User Id=$SQL_USER;Password=$SQL_PASSWORD;TrustServerCertificate=True;" \
    /p:BlockOnPossibleDataLoss=false && break || {
      echo "⏳ SQL Server not ready, retrying ($i)..."
      sleep 5
    }
done

echo "✅ DACPAC deployment complete!"
