#!/bin/bash
echo "==============================================="
echo "   斯塔克工业商店 - 后台管理系统"
echo "==============================================="
echo ""
echo "正在启动管理面板..."
echo ""

# Try Chrome app mode first
if command -v google-chrome &>/dev/null; then
    open -a "Google Chrome" --args --app="https://starkstore.starkstore.duckdns.org:17199/admin"
elif command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome &>/dev/null; then
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="https://starkstore.starkstore.duckdns.org:17199/admin" &
elif command -v /Applications/Microsoft\ Edge.app/Contents/MacOS/Microsoft\ Edge &>/dev/null; then
    /Applications/Microsoft\ Edge.app/Contents/MacOS/Microsoft\ Edge --app="https://starkstore.starkstore.duckdns.org:17199/admin" &
else
    open "https://starkstore.starkstore.duckdns.org:17199/admin"
fi

echo "管理面板已打开！"
exit 0
