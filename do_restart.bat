call settings.cmd

docker stop %CONTAINER_NAME%
docker start %CONTAINER_NAME%
docker exec -it %CONTAINER_NAME% /bin/bash --login
