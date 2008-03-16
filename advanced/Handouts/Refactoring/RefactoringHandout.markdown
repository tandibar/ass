# Refactoring

Die Website http://www.refactoring.com ist die Begleithomepage des Buches Refactoring, Improving the Design of Existing Code von Martin Fowler. Auf der Seite finden sich ergänzende Informationen zu dem Buch. Außerdem ist dort die Liste der Refactorings aus dem Buch in aktueller und teilweise überarbeiteter Form zu finden, und zwar unter: http://www.refactoring.com/catalog/index.html


## Aufgabe 1

Anhand der oben angegeben Website und dem "Smells to Refactorings - Quick Reference Guide" soll nun der Customer-Movie-Rental Sourcecode refactored werden. Ziel soll es sein, nach dem Refactoring, einfacher die neue Funktion "HTML Statement drucken" hinzufügen zu können.


## Aufgabe 2

Der Kunde hat bereits bekannt gegeben, dass in absehbarer Zeit weitere Movie-Tyen hinzukommen werden und diese auch ihre eigene Abrechnungslogik haben werden. Der Code soll so refactored werden, dass das Hinzufügen von neuen Movie-Typen plus deren Abrechnungslogik, kein Problem darstellt. Achtung, Movies können während ihrer Existenz den Typ ändern (z.B. von NEW_RELEASE zu REGULAR).


## Quellen

* Refactorings: http://www.refactoring.com/catalog/index.html
* Quellcode: http://www.railsbros.de/advanced/customer-movie-rental.zip
* Smells to Refactorings - Quick Reference Guide