############################
#       Dev aliases        #
############################

.PHONY: wait-postgres
wait-postgres:
	@echo 'Waiting Postgres Server...'
	@while ! nc -z localhost 5432; do sleep 1; done
	@echo 'Postgres Server ready!'

.PHONY: prepare
prepare:
	docker-compose up -d
	@make wait-postgres

.PHONY: down
down:
	docker-compose down -v --remove-orphans
