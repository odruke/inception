NAME= inception

ENV_FILE= srcs/.env

MARIADB_VOL=/home/odruke-s/data/mariadbvol
WORDPRESS_VOL=/home/odruke-s/data/wordpressvol
CREDENTIAL_KEY=srcs/requirements/nginx/ssl/inception.key
CREDENTIAL_CRT=srcs/requirements/nginx/ssl/inception.crt

all: up

$(ENV_FILE):
	@echo "Creating .env file..."

	@echo "DOMAIN_NAME=$$(awk '/^DOMAIN_NAME / {print $$2}' secrets/credentials.txt)" >> $(ENV_FILE)

# -------- WORDPRESS VARIABLES ---------
	@echo "# WORDPRESS" >> $(ENV_FILE)

	@echo "WP_TITLE=odrukePage" >> $(ENV_FILE)

	@echo "WP_USER=$$(awk '/^USER / {print $$2}' secrets/credentials.txt)" >> $(ENV_FILE)

	@echo "WP_USER_PASSWORD=$$(cat secrets/db_password.txt)" >> $(ENV_FILE)

	@echo "WP_USER_EMAIL=$$(awk '/^USER_EMAIL / {print $$2}' secrets/credentials.txt)" >> $(ENV_FILE)

# -------- DATABASE VARIABLES ---------
	@echo "# DATABASE" >> $(ENV_FILE)

	@echo "DB_NAME=wpdatabase" >> $(ENV_FILE)

	@echo "DB_USER=$$(awk '/^USER / {print $$2}' secrets/credentials.txt)" >> $(ENV_FILE)

	@echo "DB_PASSWORD=$$(cat secrets/db_password.txt)" >> $(ENV_FILE)

	@echo "DB_ROOT_USER=$$(awk '/^ROOT/ {print $$2}' secrets/credentials.txt)" >> $(ENV_FILE)

	@echo "DB_ROOT_PASSWORD=$$(cat secrets/db_root_password.txt)" >> $(ENV_FILE)
	@echo ".env file created!"

volumes:
	@mkdir -p $(MARIADB_VOL)
	@mkdir -p $(WORDPRESS_VOL)
	@echo "Volumes directories created!"

ssl:
	bash srcs/tools/ssl.sh

up:
	docker compose -f srcs/docker-compose.yml up

build: $(ENV_FILE) volumes ssl
	docker compose -f srcs/docker-compose.yml up --build

stop:
	docker compose -f srcs/docker-compose.yml stop

down:
	docker compose -f srcs/docker-compose.yml down

status:
	docker compose -f srcs/docker-compose.yml ps

logs:
	docker compose -f srcs/docker-compose.yml logs --tail=50 nginx

clean: down
	rm $(ENV_FILE) $(CREDENTIAL_CRT) $(CREDENTIAL_KEY)
	docker system prune -af

re: clean build

.PHONY: all clean re up stop down volumes ssl status logs
