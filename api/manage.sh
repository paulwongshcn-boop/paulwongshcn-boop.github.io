#!/bin/bash
start() { cd /www/wwwroot/stark-store/api && nohup node server.js &>/tmp/cms-api.log & echo "API started"; }
stop() { pkill -f "node /www/wwwroot/stark-store/api/server.js" && echo "API stopped"; }
status() { pgrep -f "node /www/wwwroot/stark-store/api/server.js" && echo "running" || echo "stopped"; }
case "$1" in start) start;; stop) stop;; restart) stop; sleep 1; start;; *) echo "Usage: $0 {start|stop|restart|status}"; esac
