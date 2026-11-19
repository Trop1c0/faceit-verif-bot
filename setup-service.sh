#!/bin/bash

echo "🔧 Настройка systemd сервиса для FACEIT Bot"
echo "============================================"
echo ""

# Получаем текущего пользователя и директорию
CURRENT_USER="root"
CURRENT_DIR=$(pwd)
VENV_PYTHON="$CURRENT_DIR/venv/bin/python"

echo "Пользователь: $CURRENT_USER"
echo "Директория: $CURRENT_DIR"
echo "Python: $VENV_PYTHON"
echo ""

# Проверяем существует ли venv
if [ ! -f "$VENV_PYTHON" ]; then
    echo "❌ Ошибка: Виртуальное окружение не найдено!"
    echo "Сначала запустите: ./install.sh"
    exit 1
fi

# Создаем файл сервиса
SERVICE_FILE="/etc/systemd/system/faceit-bot.service"

echo "📝 Создание файла сервиса..."
cat > $SERVICE_FILE <<EOF
[Unit]
Description=FACEIT Verification Discord Bot
After=network.target

[Service]
Type=simple
User=$CURRENT_USER
WorkingDirectory=$CURRENT_DIR
Environment="PATH=$CURRENT_DIR/venv/bin"
ExecStart=$VENV_PYTHON bot.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

echo "✅ Файл сервиса создан: $SERVICE_FILE"
echo ""

# Перезагрузка systemd
echo "🔄 Перезагрузка systemd..."
systemctl daemon-reload

# Включение автозапуска
echo "🔧 Включение автозапуска..."
systemctl enable faceit-bot

echo ""
echo "✅ Настройка завершена!"
echo ""
echo "📝 Управление ботом:"
echo "  Запустить:    systemctl start faceit-bot"
echo "  Остановить:   systemctl stop faceit-bot"
echo "  Перезапуск:   systemctl restart faceit-bot"
echo "  Статус:       systemctl status faceit-bot"
echo "  Логи:         journalctl -u faceit-bot -f"
echo ""
echo "⚠️  ВАЖНО: Убедитесь что .env файл настроен перед запуском!"
echo ""
