#!/bin/sh
set -e

echo "Waiting for PostgreSQL to be ready..."
while ! nc -z "$DB_HOST" "$DB_PORT"; do
  sleep 1
done
echo "PostgreSQL is ready!"

composer dump-autoload --optimize

# Run migrations and seed database
php artisan migrate --force

php artisan cache:clear
php artisan config:clear
php artisan optimize:clear

php artisan db:seed --force

# Create storage link (ignore if it already exists)
php artisan storage:link || true

# Start PHP server and Vite dev server in the background
echo "Starting PHP development server..."
php artisan serve --host=0.0.0.0 --port=8000 &

echo "Starting Vite development server..."
npm run dev -- --host 0.0.0.0 &

# Keep container running
wait
