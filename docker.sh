#!/bin/bash

clear

# sudo docker stop $(sudo docker ps -a -q)
# sudo docker rm $(sudo docker ps -a -q)
# sudo docker rmi $(sudo docker images -q)
# sudo docker image rm $(sudo docker images -q)
# sudo docker volume rm $(sudo docker volume ls -qf dangling=true)

# # --------------------------------------------

# yes | sudo docker system prune -a
# yes | sudo docker volume prune -a
# yes | sudo docker network prune -a
# yes | sudo docker images prune -a

# --------------------------------------------

# sudo docker rm $(sudo docker ps -a -q) -f && sudo docker volume prune -f

sudo docker ps -a

# --no-log-prefix

# sudo docker compose up --build --remove-orphans --always-recreate-deps --force-recreate

# sudo docker compose up --build --remove-orphans --always-recreate-deps --force-recreate redis-master

# sudo docker run --name redis1 -p 6379:6379 -d redis

# sudo docker compose up --build

sudo docker compose up --build redis
