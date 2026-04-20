db = db.getSiblingDB('blog_db');

db.createCollection("posts", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "titre", "auteur", "vues" ],
         properties: {
            titre: {
               bsonType: "string"
            },
            auteur: {
               bsonType: "string"
            },
            vues: {
               bsonType: "int"
            }
         }
      }
   }
});
