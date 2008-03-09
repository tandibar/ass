# Tag 1, Hands-On 2: Getting started with Rails

## Ziel des Hands-on

Ein Rails Projekt aufsetzen können und die Datenbank einrichten und migrieren

## Aufgabe

1. Es soll die Projektstruktur für die "MyBlog" Applikation angelegt werden. Anschließend soll als erstes die Datenbank angelegt werden, anschließend soll das erste Modell der Applikation erzeugt werden. Als Hilfestellung dient das angefügte Flowchart der Blog-Applikation. Am Ende sollen die CRUD Funktionalitäten für das erzeugte Modell verfügbar sein und über den Browser ansprechbar sein. Mögliche Felder für einen Blogeintrag wären zum Beispiel: 
    * Titel 
    * Author (Name / Email) 
    * Inhalt 
2. Damit beim Aufruf der URL direkt die Liste aller Blogeinträge angezeigt wird, und nicht die "Welcome aboard" Nachricht von Rails, soll eine Default Route eingerichtet werden.
3. Mit Hilfe von <code>ActiveRecord::Migration</code> sollen die nötigen Datenbank-Tabellen angelegt werden.


## Ressourcen

* http://www.ruby-doc.org/core
* http://api.rubyonrails.com
* http://wiki.rubyonrails.org/rails/pages/UnderstandingMigrations 
* http://wiki.rubyonrails.org/rails/pages/UsingMigrations 
* Ruby on Rails Cheat Sheet
* Rails Architektur


## Shortcuts

### Rails Projektstruktur initialisieren

<code>rails &lt;appname&gt;</code>

### Generatoren und rake-Tasks

* Scaffolding: <code>script/generate scaffold &lt;ModelName&gt;</code> 
* Server starten: <code>script/server</code>
* Migration erzeugen: <code>script/generate migration &lt;name_der_migration&gt;</code> 
* Migration ausführen: <code>rake db:migrate</code> 

### Konventionen

* ActiveRecord Klassen sind immer im Singular
* ActionController Klassen sind immer im Plural


### Wichtige Dateien

* Templates: <code>RAILS_ROOT/app/views/&lt;ControllerName&gt;/&lt;action&gt;.rhtml</code>
* Controller: <code>RAILS_ROOT/app/controllers/&lt;ControllerName&gt;_controller.rb</code>
* Modelle: <code>RAILS_ROOT/app/models/&lt;ModelName&gt;.rb</code>
* Konfiguration: <code>RAILS_ROOT/config/</code>
* Routing Konfiguration: <code>RAILS_ROOT/config/routes.rb</code>
* Statische Inhalte: <code>RAILS_ROOT/public</code>

### Migrationen

Migrationsdateien: <code>db/XXX_&lt;name&gt;.rb</code> wobei XXX eine automatisch zugewiesene laufende Nummer ist.

Wichtige Methoden:

* <code>create_table / drop_table</code>
* <code>t.string :spalten_name</code> # Neue Spalte vom Typ <code>string</code> während des ‘create_table’ Blocks
* <code>t.integer :spalten_name</code> # Neue Spalte vom Typ <code>string</code> während des ‘create_table’ Blocks
* <code>add_column(table_name, column_name, type, options) / remove_column(table_name, column_name)</code>

Datentypen:

* Die Datentypen werden in die spezifischen DB Typen übersetzt. 
* <code>integer, float, datetime, date, timestamp, time, text, string, binary, boolean</code>
* relevant sind für uns hauptsächlich <code>integer, string, text, datetime und boolean</code>

**Wichtig** In der <code>self.down</code> Methode müssen immer die Aktionen der <code>self.up</code> Methode rückgängig gemacht werden. 


