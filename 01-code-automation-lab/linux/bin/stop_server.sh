#!/bin/sh -x

isExistApp=`pgrep httpd`

if [[ -n $isExistApp ]]; then
    echo "[INFO] shutdown httpd"
    service httpd stop
else
    echo "[WARN] cannot find httpd process"
    exit 1
fi
