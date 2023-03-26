#!/bin/bash

if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  exit 1
fi

path=$1

echo $path
# JSONファイルを読み込む
json=$(cat $path)

_parameters=""

# jqを使って、キーと値を順番に読み込む
for key in $(echo "$json" | jq -r 'keys[]'); do
  _parameter_key="ParameterKey=\"${key}\", "
  _parameter_value="ParameterValue=\"$(echo "$json" | jq -r ".$key")\" "
  _parameters+="$_parameter_key$_parameter_value "
done

echo $_parameters
