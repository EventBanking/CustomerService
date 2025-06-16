param (
    [string]$SolutionPath = './EventBankingCo.CustomerService.sln',
    [string]$SqlProjPath = './EventBankingCo.CustomerService.Database/EventBankingCo.CustomerService.Database.sqlproj',
    [string]$DacpacPath = './EventBankingCo.CustomerService.Database/bin/Output/EventBankingCo.CustomerService.Database.dacpac'
)

# Try to find MSBuild
$msbuildPath = Get-ChildItem -Path "${env:ProgramFiles}\Microsoft Visual Studio\2022" -Recurse -Filter MSBuild.exe -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -like '*\MSBuild\Current\Bin\MSBuild.exe' } |
    Select-Object -ExpandProperty FullName -First 1

if (-not $msbuildPath) {
    Write-Error "MSBuild.exe not found in any known Visual Studio 2022 installation paths."
    exit 1
}

if (Test-Path $DacpacPath) {
    Write-Host "DACPAC found at $DacpacPath. Skipping build."
    exit 0
}

Write-Host "DACPAC not found. Building DACPAC using MSBuild at: $msbuildPath"

& $msbuildPath $SqlProjPath /p:Configuration=Debug /p:Platform="Any CPU"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to build DACPAC"
    exit $LASTEXITCODE
}

if (-Not (Test-Path $DacpacPath)) {
    Write-Error "DACPAC still not found after build"
    exit 1
}

Write-Host "DACPAC built successfully at $DacpacPath"
exit 0
