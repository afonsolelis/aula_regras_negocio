#!/bin/bash

# Script para aguardar o PostgreSQL ficar pronto

until nc -z db 5432; do
  echo "Aguardando o PostgreSQL..."
  sleep 1
done

exec "$@"
