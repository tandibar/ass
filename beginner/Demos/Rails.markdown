= Rails Demo


== Rails Projekt aufsetzen

mkdir tmp
cd tmp
rails myblog
ll
cd myblog
mate .
--> Projektstruktur zeigen
script/server
http://localhost:3000
index.html löschen
database.yml
http://localhost:3000 --> Fehler
script/generate scaffold article
alle generierten Files zeigen
routes.rb öffnen
http://localhost:3000/articles --> database-error
CREATE TABLE articles(id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(255), content TEXT);
DROP TABLE articles;
script/destroy scaffold article
script/generate scaffold article title:string content:text
rake db:migrate
http://localhost:3000/articles
Komplettes CRUD-Interface