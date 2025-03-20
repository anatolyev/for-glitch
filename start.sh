#!/bin/bash

# Завершение работы при обнаружении ошибок
set -eu

# Python буферизует стандартный вывод. Без этого вы не увидите, что вы "печатаете" в журналах действий
export PYTHONUNBUFFERED=true

# Установка Python 3 в виртуальную среду
VIRTUALENV=./venv

if [ ! -d $VIRTUALENV ]; then
  python3.11 -m venv $VIRTUALENV
fi

# Установка pip в виртуальную среду
if [ ! -f $VIRTUALENV/bin/pip ]; then
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/pip/3.11/get-pip.py | $VIRTUALENV/bin/python
fi

# Установка requirements
$VIRTUALENV/bin/pip install -r requirements.txt

# Запуск нашего приложения
$VIRTUALENV/bin/python3 main.py