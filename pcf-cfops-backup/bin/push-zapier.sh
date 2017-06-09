#!/bin/bash
set -ue
apt-get update -y && apt-get install curl -y
#curl -H "Content-Type: application/json" -X POST -d '{"access_token":"'"$access_token"'","environment":"'"$environment"'", #"local_username":"'"$local_username"'", "title": "'"$title"'", "text":"'"$text"'", "alert_type": "'"$alert_type"'", "revision":"'"$revision"'", "success": #"'"$success"'", "newrelic_app_url": "'"$newrelic_app_url"'", "newrelic_api_key": "'"$newrelic_api_key"'", "push_newrelic": "'"$push_newrelic"'"}' $url
#else
curl -H "Content-Type: application/json" -X POST -d '{"name":"'"$pcf_env_backup"'","product":"'"$backup_product"'","passfail":"'"$passfail"'"}' $url

#Deadman snitch end point
curl $deadman
#fi
