dev:
	@docker-compose down && \
			docker-compose \
				-f docker-compose.yml \
				up -d --build
rebuild:
	@docker-compose down && \
			docker-compose build --pull --no-cache && \
			docker-compose \
				-f docker-compose.yml \
				up -d --remove-orphans

stop:
	@docker-compose down
