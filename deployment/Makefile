.PHONY: start
start:
	docker-compose -f docker-compose.yml up -d 

.PHONY: stop
stop:
	docker-compose -f docker-compose.yml down

.PHONY: restart
restart:
	docker-compose -f docker-compose.yml up -d --force-recreate

.PHONY: status
status:
	docker-compose -f docker-compose.yml ps
	docker-compose -f docker-compose.yml logs