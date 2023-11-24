#!/bin/bash

check_netstat_installed(){
    if ! netstat --version > /dev/null 2>&1; then
        echo "ERROR: netstat is not installed"
        echo "SOLUTION: install the dependency and try again!"
        exit 1
    fi
}


check_curl_installed(){
    if ! curl --version > /dev/null 2>&1; then
        echo "ERROR: curl is not installed"
        echo "SOLUTION: install the dependency and try again!"
        exit 1
    fi
}

check_http_availability(){
    url="$1"

    if [ -z "$url" ]; then
        exit 1
    fi

    if curl --output /dev/null --silent --head --fail "$url"; then
        echo "OK: Server is running on $url"
    else
        echo "ERROR: Server is not running on $url"
        echo "SOLUTION: Please check the logs and try again."
        exit 1
    fi
}

check_local_mqtt_availability(){
    if netstat -lnt | grep ':1883 .*LISTEN' >/dev/null; then
        echo "OK: MQTT is running on port 1883"
    else
        echo "ERROR: MQTT is not running on port 1883"
        exit 1
    fi
}
