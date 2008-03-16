# Plugins

Plugins erweitern die Funktionalität von Ruby on Rails. Sie liegen im Verzeichnis `RAILS_ROOT/vendor/plugins`. Über `script/plugin` werden alle nötigen Tools zur Verfügung gestellt um Plugins zu installieren und zu verwalten. Außerdem kann über `script/generate plugin <name>` ein neues Plugin erstellt werden.

## Aufgabe

Erstellt ein Plugin, in dem die Methoden, die für ein Authentifizierung nötig sind, gekapselt werden. D.h. standard Felder, die nötig sind sollten enthalten sein, wie

* login_name, als Standard z.B. E-Mail Adresse
* salted_password
* salt

Außerdem sollten folgende Methoden zur Verfügung stehen:

* Authentifizierungsmethode, checkt, ob Login-Name und Passwort zusammen passen
* change_passwort, eine Methode die das Passwort ändert

Desweitern sollte das Verschlüsseln des Passworts komplett in dem Plugin gekapselt sein. Das heißt, nach außen muss man sich keine Gedanken um die Verschlüsselung machen müssen.