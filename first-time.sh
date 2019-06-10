./container-exec.sh '/composer install && \
php artisan migrate:refresh --seed && \
php artisan storage:link && \
php artisan passport:install --force -n'
