call settings.cmd

docker run -d -p %PORT%:3000 -p %PGPORT%:5432 -v %RAILSAPP_DIR%:/railsapp --name %CONTAINER_NAME% %IMAGE_NAME% redis-server
