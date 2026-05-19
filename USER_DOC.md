# USER DOCUMENTATION

## Services provided
This stack runs three services:
- Nginx: HTTPS reverse proxy that serves the site and forwards PHP requests.
- WordPress (PHP-FPM): the web application.
- MariaDB: the database used by WordPress.

## Start and stop the project
Run commands from the repository root:
- First time build and start: `make build`
- Start existing containers: `make up`
- Stop containers (keep data): `make stop`
- Stop and remove containers: `make down`
- Show container status: `make status`
- Show recent nginx logs: `make logs`
- Full cleanup (removes `srcs/.env` and SSL certs): `make clean`
- Full cleanup and rebuild: `make re`

## Access the website and the admin panel
1. Map the domain to localhost in `/etc/hosts`:
   `127.0.0.1 <your-domain>`
2. Open the site: `https://<your-domain>`
   - The certificate is self-signed, so your browser will show a warning.
3. Open the admin panel: `https://<your-domain>/wp-admin`

## Locate and manage credentials
A secrets folder must be present at  `secrets/`, containing the following files and content:
- `secrets/credentials.txt` (contains `DOMAIN_NAME domain`, `USER username`, `ROOT rootname`, `USER_EMAIL user@email.com`)
- `secrets/db_password.txt` (used for `WP_USER_PASSWORD` and `DB_PASSWORD`)
- `secrets/db_root_password.txt` (used for `DB_ROOT_PASSWORD`)

A runtime file is generated from those secrets:
- `srcs/.env` (created by `make build`)

The generated `.env` includes these keys:
- `DOMAIN_NAME`, `WP_TITLE`, `WP_USER`, `WP_USER_PASSWORD`, `WP_USER_EMAIL`
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_ROOT_USER`, `DB_ROOT_PASSWORD`

`DOMAIN_NAME` controls the URL you open in the browser and the CN used in the SSL certificate.

If you change any secrets, remove the old `.env` and rebuild:
- `make clean`
- `make build`

If you change `DOMAIN_NAME`, run `make clean` to force SSL certificate regeneration.

## Check that services are running correctly
- Container status: `make status`
- Recent logs: `make logs`
- Browser check: open `https://<your-domain>` and log in at `/wp-admin`
