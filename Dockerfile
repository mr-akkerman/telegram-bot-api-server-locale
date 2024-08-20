# Используем Ubuntu 22.04 как базовый образ
FROM ubuntu:22.04

# Устанавливаем необходимые зависимости
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y make git zlib1g-dev libssl-dev gperf cmake g++

# Клонируем репозиторий telegram-bot-api
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

# Устанавливаем рабочую директорию
WORKDIR /telegram-bot-api

# Собираем проект
RUN rm -rf build && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. && \
    cmake --build . --target install

# Устанавливаем рабочую директорию обратно в корень
WORKDIR /

# Проверяем наличие собранного файла
RUN ls -l /telegram-bot-api/bin/telegram-bot-api*

# Копируем скрипт запуска
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Устанавливаем точку входа на наш скрипт запуска
ENTRYPOINT ["/start.sh"]