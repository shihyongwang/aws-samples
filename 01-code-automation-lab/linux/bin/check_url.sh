#!/bin/sh -x

declare -a arr=("/internal/phpinfo.php" "/index.html")

for i in "${arr[@]}"
do
    response=$(curl --write-out '%{http_code}' --silent --max-time 10 --output /dev/null http://127.0.0.1${i})
    if [[ 200 -ne $response ]]; then
        echo "[WARN] cannot check URL: ${i}"
        exit 1
    fi
done
