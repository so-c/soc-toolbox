@echo off
@rem ユーザー定義音声連携ファイル

pushd %~dp0

set CUR_DIR=%~dp0
set CUR_DIR2=%CUR_DIR:\=\\%
set BEFORE=-File \"\"
set  AFTER=-File \"%CUR_DIR2%coeica.ps1\"

setlocal enabledelayedexpansion
cd .\template
for /f "usebackq delims=" %%a in ("COEIROINKv2(PowerShell 5.1).rvls.org") do (
    set CONF=%%a
    echo !CONF:%BEFORE%=%AFTER%!>"..\COEIROINKv2(PowerShell 5.1).rvls"
)

endlocal
popd
