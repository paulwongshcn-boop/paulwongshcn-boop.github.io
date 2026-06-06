#!/bin/bash
echo "==============================================="
echo "   斯塔克工业商店 - 后台管理系统"
echo "==============================================="
echo ""
echo "正在启动管理面板..."
echo ""

if command -v google-chrome &>/dev/null; then
    google-chrome --app="https://starkstore.starkstore.duckdns.org:17199/admin" &
elif command -v chromium-browser &>/dev/null; then
    chromium-browser --app="https://starkstore.starkstore.duckdns.org:17199/admin" &
elif command -v firefox &>/dev/null; then
    firefox --new-window "https://starkstore.starkstore.duckdns.org:17199/admin" &
else
    xdg-open "https://starkstore.starkstore.duckdns.org:17199/admin"
fi
echo "管理面板已打开！"
