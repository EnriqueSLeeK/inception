
all: compose
	
create-data-dir:
	[ -d ~/data ] || (mkdir ~/data && mkdir ~/data/mdata && mkdir ~/data/wdata && mkdir ~/data/dwiki)
	
build: create-data-dir
	docker-compose --file srcs/docker-compose.yml up --detach --build
	
compose: create-data-dir
	docker-compose --file srcs/docker-compose.yml up --detach

compose-build: create-data-dir
	docker-compose --file srcs/docker-compose.yml up --build --detach

# This will add an entry in the hosts files and create a backup	
host-config:
	[ ! -d back-host ] \
		&& mkdir back-host \
		&& cp /etc/hosts back-host/ \
		&& sudo echo "127.0.0.1 ensebast.42.fr" | sudo tee -a /etc/hosts > /dev/null

# Substitute the modified hosts file with the backup 
restore-host:
	[ -d back-host ] \
		&& sudo mv back-host/hosts /etc/hosts \
		&& rmdir back-host

# CLean containers
down:
	docker-compose --file srcs/docker-compose.yml down

# Clean cache, images, etc....
prune: down
	docker system prune -f -a
	docker volume rm srcs_wordpress
	docker volume rm srcs_mariadb-volume
	docker volume rm srcs_wiki-volume

# Wipe and restore the hosts file
clean-all: prune
	sudo rm -rf ~/data

re: prune compose

.PHONY: re prune prune prune compose host-config restore-host