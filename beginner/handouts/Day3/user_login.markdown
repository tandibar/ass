# Tag 2, Hands-On 9: User Login

## Ziel des Hands-on

* Die Stateless-Problematik von HTTP verstanden haben und mit der Session umgehen können.
* Einen User Login zumindest konzeptionell realisieren können.

## Aufgabe

Natürlich soll nicht jeder beliebige Besucher auf unserem Blog einen Artikel veröffentlichen können. Diese Funktion soll nur bestimmten, registrierten Benutzern ermöglicht werden. Dazu muss:

1. Sich ein Benutzer einloggen können (zuerst muss er sich zwar registrieren, dieser Schritt soll hier jedoch nicht implementiert werden) und
2. Der Zugang zu bestimmten Teilen der Applikation muss gesperrt werden.

Weiterhin ist zu beachten, dass das Passwort nicht im Klartext gespeichert werden darf!

## Ressourcen

* http://api.rubyonrails.com -> ActionController::Session und ActionController::Filter

## Shortcuts

* Die Authentifizierung von Benutzern im System muss auf verschiedenen Ebenen implementiert werden:
  1. Das Modell <code>User</code> muss die Funktionen implementieren einen Benutzer anhand seiner Credentials zu identifizieren (Bsp: Email + Passwort)
  2. Der Controller muss den Zugang zu bestimmten Funktionen für nicht registrierte Benutzer untersagen
  3. Sobald sich ein Benutzer sich in das System eingeloggt hat, muss dieser Status irgendwo gespeichert werden.

### Filter

In den Controllern können Filter definiert werden, die sicherstellen, dass eine bestimmte Aktion ausgeführt wird bevor oder nachdem eine Action ausgeführt wurde. Zusätzlich lassen sich die Actions einschränken, bei denen der Filter greift. Es gibt unterschiedliche Arten von Filtern, an dieser Stelle ist vor allem der <code>before_filter</code> von Interesse. Diese Klassenmethode erhält als Parameter eine Referenz in Form eines Symbols oder Strings auf eine Methode (die typischerweise als <code>private</code> deklariert wurde). Als weitere Parameter akzeptiert die Methode ein Hash mit den Actions die gefilter oder nicht gefiltert werden sollen.

Bsp.:

<pre><code>
before_filter :authenticated, :only => [:edit, :update, :new, :create, :destroy]
</code></pre>

oder 

<pre><code>
before_filter :authenticated, :except => [:index, :show]
</code></pre>

### Hashfunktion

![Hashfunktion](/Users/dbreuer/Desktop/Hashfunktion.png)

* Die Klasse <code>Digest::SHA1</code> und deren Methode <code>Digest::SHA1.hexdigest(str)</code> hashen eine String.

### Sessions

**Erster** Request:

![Sessions1](/Users/dbreuer/Desktop/sessions1.png)

**Zweiter** Request:

![Sessions2](/Users/dbreuer/Desktop/sessions2.png)

* Die Methode <code>session</code> im Controller liefert Zugriff auf das Session Hash.
* In der Session sollten keine Objekte oder vertrauliche Daten gespeichert werden.
* Die Session sollte nicht im Cookie hinterlegt werden, jedoch für unseren Einsatz nicht so entscheidend.
