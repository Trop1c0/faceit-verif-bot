#!/bin/bash

echo "🚀 Установка FACEIT Verification Bot на Ubuntu 24.04"
echo "=================================================="
echo ""

# Обновление системы
echo "📦 Обновление системы..."
sudo apt update

# Установка зависимостей
echo "📦 Установка Python и зависимостей..."
sudo apt install -y python3 python3-pip python3-venv

# Создание виртуального окружения
echo "🔧 Создание виртуального окружения..."
python3 -m venv venv

# Активация виртуального окружения
echo "🔧 Активация виртуального окружения..."
source venv/bin/activate

# Установка pip пакетов
echo "📦 Установка Python пакетов..."
pip install --upgrade pip
pip install -r requirements.txt

# Создание .env файла если его нет
if [ ! -f .env ]; then
    echo "📝 Создание .env файла..."
    cp .env.example .env
    echo "⚠️  ВАЖНО: Отредактируйте файл .env перед запуском!"
fi

echo ""
echo "✅ Установка завершена!"
echo ""
echo "📝 Следующие шаги:"
echo "1. Отредактируйте .env файл: nano .env"
echo "2. Запустите бота: source venv/bin/activate && python bot.py"
echo ""
echo "Для автозапуска через systemd см. инструкцию в документации"
echo ""
