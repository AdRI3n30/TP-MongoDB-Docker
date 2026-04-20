#!/bin/bash

CONTAINER="mongodb"
[ -f .env ] && export $(grep -v '^#' .env | xargs) || { echo "ERREUR: le fichier .env absent"; exit 1; }

echo "--- TESTS DE VIABILITE ---"

USER=$(docker exec $CONTAINER whoami | tr -d '\r')
echo "Utilisateur : $USER"

if [ "$USER" != "mongodb" ]; then
    echo "ERREUR: Le service tourne en root !"; exit 1
fi

COUNT=$(docker exec $CONTAINER mongosh -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --quiet --eval "db.getSiblingDB('blog_db').posts.countDocuments()" | tr -d '\r')

if [[ "$COUNT" =~ ^[0-9]+$ ]] && [ "$COUNT" -ge 5 ]; then
    echo "SUCCÈS: Base OK ($COUNT articles)"
else
    echo "ERREUR: Base injoignable ou données incomplètes ($COUNT)"; exit 1
fi

echo "--- TOUT EST CONFORME ---"