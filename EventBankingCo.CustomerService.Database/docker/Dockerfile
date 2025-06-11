FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=EventBankingCo_CustomerService_DB_Password

USER root
WORKDIR /usr/src/app

# Install SQLCMD and required dependencies
RUN apt-get update && \
    apt-get install -y curl apt-transport-https gnupg unixodbc-dev && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && \
    ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add SQLCMD to PATH (safe for shell sessions)
ENV PATH="/opt/mssql-tools/bin:$PATH"

# Copy database setup files
COPY docker/entrypoint.sh /usr/src/app/entrypoint.sh
COPY dbo /usr/src/app/dbo
COPY Scripts /usr/src/app/Scripts
COPY init-db.sql /usr/src/app/init-db.sql

# Make entrypoint executable
RUN chmod +x /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
