# Tag 1, Hands-On 3: Validierungen

## Aufgabe

1. Da gerade bei einem Blogsystem die Daten typischerweise aus einer Benutzereingabe in die Datenbank geschrieben werden, sollen diese Eingaben nicht ungesehen in der Datenbank landen. ActiveRecord bietet dafür sowohl fertige Validatoren an, als auch die Möglichkeit eigene Validierungen zu definieren. Aufgabe ist es also die Felder eines Blogeintrags entsprechend zu validieren, so dass keine unkorrekten oder gar bösartige Werte in der Datenbank landen. 
2. Falls ein User eine nicht-valide Eingabe vornimmt soll er darüber informiert werden.

## Ressourcen

* http://api.rubyonrails.com/classes/ActiveRecord/Validations.html 
* http://api.rubyonrails.com/classes/ActiveRecord/Validations/ClassMethods.html 

## Wichtige Informationen

* Die Validierung findet statt bevor das Objekt gespeichert wird. 
* Jedes ActiveRecord Objekt hat eine <code>validate</code> Methode, mit der die Validierung explizit getriggert werden kann. 
* Scheitert eine Validierung, so wird die Fehlermeldung an das errors Hash des Objekts angehangen und kann in der View zur Fehlerausgabe verwendet werden. 
* Typischerweise verwendet man das flash Objekt zur Ausgabe solcher Meldungen (das flash Objekt ist ein Hash, durch das Scaffolding wissen die Views bereits, dass es einen Key <code>notice</code> im <code>flash</code> Hash geben kann). 

Einige Standardvalidierungen:

* validates_presence_of :name 
* validates_uniqueness_of :key 
* validates_format_of :email 
* validates_size_of :password 

Eigene Validierung:

<pre><code>def validate 
  errors.add(birthday, "Who are you? Methusalem?") unless birthday &lt; Time.parse("01-01-1850") 
end</code></pre>