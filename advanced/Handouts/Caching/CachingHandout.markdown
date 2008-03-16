# Caching in Rails

## Page Caching

Page Caching legt die fertig gerenderte Datei so im Filesystem ab, dass sie beim nächsten Request direkt ausgeliert werden kann ohne Rails zu berühren. Dadurch ist dies nur für Seiten möglich, die keine Zugangsbeschränkung haben und die für alle Besucher gleich aussehen.

## Action Caching

Action Caching funktioniert ähnlich dem Page Caching, nur dass Rails noch so weit durchlaufen wird, dass before und after (oder auch around) Filter noch ausgeführt werden. Somit ist dies auch für Zugangsbeschränkte Seiten möglich.

## Fragment Caching

Fragment Caching speichert einzelne Fragmente eines Rendering-Prozesses im Filesystem (oder auch in anderen Cache-Systemen). Somit müssen diese Renderings nicht nochmal durchgeführt werden, sondern können von der Platte gelesen werden.

## Sweeper

Sweeper überwachen ein oder mehrere Models. Wenn auf diesen Models Änderungen vorgenommen werden, wird der Sweeper über Callbacks darüber informiert und kann entsprechende Maßnahmen ergreifen, um ein Caching auslaufen zu lassen.

## Aufgabe

Es soll ein sinnvolles Caching der unterschiedlichen Blog-Seiten ermöglicht werden. Schätzt dabei genau ab, welches Caching an welcher Stelle sinn macht. Außerdem soll ein entsprechender Sweeper implemntiert werden, der dafür sort, dass der Cache zu den richtigen Zeitpunkten geleert wird. 


## Quellen

* http://www.railsenvy.com/2007/2/28/rails-caching-tutorial
* Ryan Bates Railscasts Episoden 89, 90 und 93 (http://railscasts.com)
* API Ruby on Rails, ActionController::Caching (http://api.rubyonrails.org)
* Bros-Blog Quellcode (http://railsbros.de/advanced/bros_blog.zip)


![PageActionFragmentCaching](/Users/abade/Jobs/Kurse/ass/advanced/Grafiken/PageActionFragmentCaching.jpg)