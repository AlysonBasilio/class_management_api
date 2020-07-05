docker container run -d --rm -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e PGDATA=/var/lib/postgresql/data/pgdata -v $(pwd)/pgdata:/var/lib/postgresql/data --name postgres --network poc_network --network-alias postgres --publish 5432:5432 postgres:12.1-alpine
docker container run --rm -v $(pwd):/app -w /app --user $(id -u):$(id -g) --name class_management_api --network poc_network --network-alias order-api --publish 4000:4000 elixir-phoenix:alyson mix phx.server
