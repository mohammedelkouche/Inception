# Default target

# .PHONY: all
all: up

# Build Docker images
# .PHONY: build
build:
	docker-compose -f ./srcs/docker-compose.yml build

# Start containers
# .PHONY: up
up: build
	docker-compose -f ./srcs/docker-compose.yml up

# Stop containers
# .PHONY: down
down:
	docker-compose -f ./srcs/docker-compose.yml down

# Clean up containers and volumes
# .PHONY: clean

clean-images:
	docker rmi -f $$(docker images -aq)

clean-cv:
	docker-compose -f ./srcs/docker-compose.yml down -v

fclean: clean-cv clean-images