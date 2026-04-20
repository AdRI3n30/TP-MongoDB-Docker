#!/bin/bash

CONTAINER_NAME="mongodb"
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "ERREUR : Fichier .env introuvable !"
    exit 1
fi

echo "--- DEBUT DES TESTS DE VIABILITE ---"


echo "1. Vérification de l'utilisateur interne..."
INTERNAL_USER=$(docker exec $CONTAINER_NAME whoami )
echo "Utilisateur détecté : $INTERNAL_USER"

if [ "$INTERNAL_USER" = "mongodb" ]; then
    echo "SUCCÈS : Le service s'exécute bien en tant que 'mongodb'."
else
    echo "ERREUR : Le service s'exécute en tant que $INTERNAL_USER (Attendu: mongodb) !"
    exit 1
fi

echo "2. Vérification de l'accès à la base blog_db..."

COUNT=$(docker exec $CONTAINER_NAME mongosh \
    -u "$MONGO_INITDB_ROOT_USERNAME" \
    -p "$MONGO_INITDB_ROOT_PASSWORD" \
    --quiet --eval "db.getSiblingDB('blog_db').posts.countDocuments()" | tr -d '\r')

if [[ "$COUNT" =~ ^[0-9]+$ ]]; then
    if [ "$COUNT" -ge 5 ]; then
        echo "SUCCÈS : La base répond et contient bien $COUNT articles."
    else
        echo "ERREUR : Données incomplètes (Trouvé: $COUNT articles, attendu: 5)."
        exit 1
    fi
else
    echo "ERREUR : Impossible de se connecter à la base ou erreur d'authentification."
    echo "Détail de l'erreur : $COUNT"
    exit 1
fi

echo "--- TOUS LES POINTS DE CONTROLE SONT CONFORMES ---"