#!/bin/bash

# Проверяем, что API_ID и API_HASH предоставлены
if [ -z "$API_ID" ] || [ -z "$API_HASH" ]; then
    echo "Error: API_ID and API_HASH must be provided as environment variables."
    exit 1
fi

# Запускаем telegram-bot-api с предоставленными параметрами
exec /telegram-bot-api/bin/telegram-bot-api --local --api-id="$API_ID" --api-hash="$API_HASH"