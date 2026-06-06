@echo off
title 斯塔克工业商店 - 管理后台
echo ===============================================
echo    斯塔克工业商店 - 后台管理系统
echo ===============================================
echo.
echo 正在启动管理面板...
echo.
:: Try Edge first, then Chrome
start msedge --app="https://starkstore.starkstore.duckdns.org:17199/admin" --new-window 2>nul
if errorlevel 1 (
    start chrome --app="https://starkstore.starkstore.duckdns.org:17199/admin" --new-window 2>nul
    if errorlevel 1 (
        start "" "https://starkstore.starkstore.duckdns.org:17199/admin"
    )
)
echo 管理面板已打开，请稍候...
timeout /t 3 /nobreak >nul
exit
