#!/bin/bash

# Проверяем, запущены ли контейнеры
if ! docker-compose ps | grep -q "backend.*running"; then
    echo "❌ Сервис backend не запущен. Запустите docker-compose up -d"
    exit 1
fi

echo "🔄 Загрузка демо-данных..."

# Ждем, пока база данных будет готова
echo "⏳ Ожидание готовности базы данных..."
sleep 5

# Применяем миграции
echo "📦 Применение миграций..."
docker-compose exec -T backend python manage.py migrate --noinput > /dev/null 2>&1

# Загружаем демо-данные
echo "🚗 Загрузка демо-данных..."
docker-compose exec -T backend python manage.py load_demo_data > /dev/null 2>&1

echo "✅ Демо-данные успешно загружены!"
echo "
Доступ к админ-панели:
URL: http://localhost:8000/admin/
Логин: admin
Пароль: admin123

Демо-пользователь:
Логин: demo
Пароль: demo123
" 