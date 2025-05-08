.PHONY: up down re logs ps clean fclean prune

COMPOSE=docker-compose
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
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down -v --remove-orphans

fclean: clean
	docker volume rm mariadb_data || true
	docker image rm mariadb || true

prune:
	docker system prune -af --volumes
