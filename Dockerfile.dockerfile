FROM mcr.microsoft.com/mssql/server:2022-latest

ENV SA_PASSWORD=3v3nTp@sSw0rD
ENV ACCEPT_EULA=Y

# Copy DACPACs and optionally sqlpackage installer
COPY ./dacpac /var/opt/mssql/dacpac
