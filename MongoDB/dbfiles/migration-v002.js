db = db.getSiblingDB('blog_db');
db.posts.insertMany([
   { titre: "Introduction à Docker", auteur: "Adrien", vues: 150 },
   { titre: "Sécurité MongoDB", auteur: "Adrien", vues: 85 },
   { titre: "Le NoSQL en 2026", auteur: "Adrien", vues: 200 },
   { titre: "Optimisation Images", auteur: "Adrien", vues: 45 },
   { titre: "Guide des Volumes", auteur: "Adrien", vues: 120 }
]);