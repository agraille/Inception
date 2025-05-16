.PHONY: up down re logs ps clean fclean prune

COMPOSE=docker compose
COMPOSE_FILE=srcs/docker-compose.yml
ENV_FILE=srcs/.env

up:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up --build -d

down:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down

re: fclean up

logs:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) logs -f

ps:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) ps

clean:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down --remove-orphans

fclean: clean
	docker volume rm srcs_wordpress_data || true
	docker volume rm srcs_mariadb_data || true
	docker image rmi wordpress
	docker image rmi mariadb
	docker image rmi srcs-nginx
	docker image rmi srcs-redis
	docker image rmi srcs-adminer
	docker image rmi srcs-site
	docker image rmi srcs-ftp

prune:
	docker system prune -af --volumes
