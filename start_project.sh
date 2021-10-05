#!/usr/bin/env bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
FOLDER_WITH_SCRIPTS="core_scripts"

# Весь вывод дублируется в файл
LOG_LOCATION=$SCRIPTPATH/.default/log
exec > >(tee $LOG_LOCATION) 2>&1

# Подгружаем настройки переменных
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then

  export $(grep -v '^#' $SCRIPTPATH/.default/.env | xargs -d '\n')
  export $(grep -v '^#' $SCRIPTPATH/.env | xargs -d '\n')


elif [ "$unamestr" = 'Darwin' ]; then

  export $(grep -v '^#' $SCRIPTPATH/.default/.env | xargs -I '\n')
  export $(grep -v '^#' $SCRIPTPATH/.env | xargs -I '\n')

elif [ "$unamestr" = 'FreeBSD' ]; then

  export $(grep -v '^#' $SCRIPTPATH/.default/.env | xargs -0)
  export $(grep -v '^#' $SCRIPTPATH/.env | xargs -0)

fi

compose_start() {
  docker-compose -f  docker-compose.yaml up
}

code_reload() {
  docker-compose up --detach --build
}

if [ $1 = 'reload' ]; then
  code_reload
elif [ $1 = 'start' ]; then
  compose_start
fi
