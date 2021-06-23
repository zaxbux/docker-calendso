#!/bin/sh

# Create DATABASE_URL from individual env vars
if [ -z "$DATABASE_URL" ]; then
	export DATABASE_URL="postgresql://${POSTGRES_USER:=postgres}:$POSTGRES_PASSWORD@$POSTGRES_HOST:${POSTGRES_PORT:=5432}/$POSTGRES_DB?schema=data"
fi

# development
#npx prisma db push

# production
npx prisma migrate deploy

exec $@
