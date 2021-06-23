#!/bin/sh

# Create DATABASE_URL from individual env vars
if [ -z "$DATABASE_URL" ]; then
	export DATABASE_URL="postgresql://${POSTGRES_USER:=postgres}:$POSTGRES_PASSWORD@$POSTGRES_HOST:${POSTGRES_PORT:=5432}/$POSTGRES_DB?schema=data"
fi

# Generate a `schema.prisma` file if one was not mounted
if [[ ! -f "schema.prisma"  ]]; then
	cat <<EOF > schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}
EOF
	npx prisma db pull
	npx prisma introspect
	npx prisma generate
fi

exec $@