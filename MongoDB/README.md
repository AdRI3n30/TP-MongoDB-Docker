# MongoDB Blog Migration

Base de données MongoDB sécurisée pour un blog, déployée avec Docker.

## Objectif

Ce projet met en place :

- une instance MongoDB durcie ;
- une exécution en utilisateur non privilégié ;
- des scripts de migration ;
- une validation de schéma NoSQL sur la collection `posts`.

## Prérequis

- Docker installé (version récente recommandée)
- accès à un terminal Bash (Linux/macOS/WSL/Git Bash)

## Installation et lancement

### 1 Construire l'image

```bash
docker build -t shinjodeku/mongo-blog:1.0.0 .
```

### 2 Configurer les variables d'environnement

Créer un fichier `.env` à la racine du projet (à partir de `.env.example` si présent).

### 3 Démarrer le conteneur

```bash
docker run -d --env-file .env --name mongodb shinjodeku/mongo-blog:1.0.0
```

## Vérification

Pour contrôler l'état du déploiement :

```bash
./check-status.sh
```

## Sécurité et validation

- **Utilisateur** : le service s'exécute avec l'utilisateur `mongodb` (non-root).
- **Image de base** : `mongo:8.2.7`.
- **Validation des données** : un JSON Schema Validator est appliqué à la collection `posts`.

## Structure du dossier

```text
MongoDB/
├── check-status.sh
├── Dockerfile
├── .env.example
├── README.md
└── dbfiles/
   ├── migration-v001.js
   └── migration-v002.js
└── Capture-d'ecran/
   ├── Preuve-2.png
   ├── Preuve-4.png
   ├── Preuve-find().png
   └── Preuve-test-script.png   
```

## Docker Hub

Image publique :

- [shinjodeku/mongo-blog](https://hub.docker.com/r/shinjodeku/mongo-blog)
