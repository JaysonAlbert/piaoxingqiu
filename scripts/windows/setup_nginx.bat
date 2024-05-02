@echo off
setlocal

set NGINX_DIR=C:\nginx
set SITES_AVAILABLE=%NGINX_DIR%\conf\sites-available
set SITES_ENABLED=%NGINX_DIR%\conf\sites-enabled

echo Checking and creating directories if they do not exist...

if not exist "%SITES_AVAILABLE%" (
    echo Creating %SITES_AVAILABLE%...
    mkdir "%SITES_AVAILABLE%"
)

if not exist "%SITES_ENABLED%" (
    echo Creating %SITES_ENABLED%...
    mkdir "%SITES_ENABLED%"
)

echo Directories setup complete.

copy deployment/nginx/flutter_nginx.conf SITES_AVAILABLE\
set SITE_CONF=%SITES_AVAILABLE%\flutter_nginx.conf
if not exist "%SITES_ENABLED%\%SITE_CONF%" (
    echo Creating symbolic link for %SITE_CONF%...
    cd /d %SITES_ENABLED%
    mklink %SITE_CONF% ..\sites-available\%SITE_CONF%
)

echo All done.

endlocal
pause
