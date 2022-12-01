all:
	@bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

stop:
	@docker-compose -f srcs/docker-compose.yml stop

down:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

info:
	docker ps
	docker ps -a
	docker images
	docker network ls
	docker volume ls

portainer:
	@docker volume create portainer_data
	@docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

ps:
	@docker-compose -f srcs/docker-compose.yml ps

clean: down
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
	
fclean:
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker container prune -f
	@docker image prune -f
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY	: all build down re clean fclean