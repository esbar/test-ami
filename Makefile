build:
	docker build --no-cache .
	docker build -t lordarshen/filter-ami .
	docker push lordarshen/filter-ami
	