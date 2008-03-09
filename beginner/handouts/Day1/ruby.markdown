# Tag 1, Hands-On 1: Getting started with Ruby

## Ziel des Hands-on

Ruby Syntax verstehen und in den Grundzügen schreiben können.

## Aufgabe

1. Gib auf vier verschiedene Arten den String "Hello World!" viermal auf dem Bildschirm aus. Die unterschiedlichen Methoden sollten möglichst kreativ sein!
2. Eine Liste von Studenten, die Matrikelnummern den Namen der Studenten zuweist (mind. 4 Studenten in der Liste). Aus dieser Liste sollen die Namen sortiert ausgegeben werden.
3. Make an <code>OrangeTree</code> class. It should have a <code>height</code> method which returns its height, and a <code>one_year_passes</code> method, which, when called, ages the tree one year. Each year the tree grows taller (however much you think an orange tree should grow in a year), and after some number of years (again, your call) the tree should die. For the first few years, it should not produce fruit, but after a while it should, and I guess that older trees produce more each year than younger trees... whatever you think makes most sense. And, of course, you should be able to <code>count_the_oranges</code> (which returns the number of oranges on the tree), and <code>pick_an_orange</code>  (which reduces the <code>@orange_count</code> by one and returns a string telling you how delicious the orange was, or else it just tells you that there are no more oranges to pick this year). Make sure that any oranges you don't pick one year fall off before the next year. ("Learn to Program" von Chris Pine)

## Ressourcen

* http://www.ruby-doc.org/
* Ruby Cheat Sheet

## Shortcuts

### Environment Setup

<code>export PATH=/usr/local/bin:$PATH</code><br />
<code>export http_proxy=http://wwwproxy-gm.fh-koeln.de:8080</code>

### Strings

<pre><code>"Das ist ein String"</code>
<code>'Das hier auch'</code></pre>

### Symbols    

<code>:das_ist_ein_symbol</code>

### Arrays

<pre><code>[1,2,3]</code>
<code>%w(eins zwei drei)</code></pre>

### Hash

<code>{ :key => 'value', :another_key => 'another_value' }</code>

### Ranges

<code>0..4</code>

### Schleifen

<code>4.times { |n| puts n }</code>

<pre><code>
while i &lt; 10 
  # do something 
end
</code></pre>

<code>[1,2,3].each { |x| puts x+1 }</code>

<pre><code>
for i in 0..10 do |n| 
  # do something with 'n'
end 
</code></pre>

### Ausgabe

<code>puts string</code>

### Allgemeines

* Ruby Source Dateien: <code>my_ruby_prog.rb</code>
* Ruby Interpreter starten: <code>ruby <Dateiname> </code>
* Interactive Ruby Shell starten: <code>irb</code> 
* Interactive Ruby Shell starten und Bibliothek laden: <code>irb -r bib.rb</code>
* Rückgabewerte: Eine Funktion gibt immer den zuletzt evaluierten Wert 
zurück, auch ohne Angabe des Schlüsselworts <code>return</code>. 

### Konventionen

* Klassen-/Modulnamen werden in CamelCase notiert
* Methodenamen werden mit Unterstrichen notiert (<code>find_by_name</code>)
* Methoden, die das Callerobjekt verändern haben einen Ausrufezeichen (<code>sort!</code>) 
* Methoden, die true oder false zurückgeben haben ein Fragezeichen (<code>instance_of?</code>) 


