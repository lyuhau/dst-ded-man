#!/usr/bin/env bash

if [[ $1 == "-u" ]]; then
  steamcmd +login anonymous +app_update 343050 +quit
  shift
elif [[ $1 == "-uv" ]]; then
  steamcmd +login anonymous +app_update 343050 validate +quit
  shift
fi

if [[ -z $1 ]]; then
  echo "Usage: start-dst-server <cluster_dir>"
  exit 1
fi

cd "$HOME/.steam/steamapps/common/Don't Starve Together Dedicated Server/bin"

echo "
screen bash -c './dontstarve_dedicated_server_nullrenderer -console -conf_dir DoNotStarveTogether -cluster $1 -shard Master'
split -v
focus right
screen bash -c 'echo waiting 15 seconds for Master shard; sleep 15; ./dontstarve_dedicated_server_nullrenderer -console -conf_dir DoNotStarveTogether -cluster $1 -shard Caves'
" > startup.screen

screen -c startup.screen
rm startup.screen
