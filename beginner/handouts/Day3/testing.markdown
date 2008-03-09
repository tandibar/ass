# Tag 2, Hands-On 8: Testing

## Ziel des Hands-on

Die Grundlagen von automatisierten Tests verstanden haben und grundlegend anwenden können.

## Aufgabe

1. Die bisher verwendeten Generatoren haben bereits einige Tests erzeugt. Jedoch werden diese, bedingt durch die durchgeführten Änderungen nicht mehr funktionieren. In diesem Hands-On sollen diese Test zum einen wieder ans Laufen gebracht werden, zum anderen sollen sie insofern erweitert werden, als dass die zusätzlichen Fähigkeiten ebenfalls getestet werden sollen. Dazu zählen dann also Tests, die überprüfen, dass ein Artikel immer einen Titel hat und ein Kommentar nicht ohne Artikel existieren kann.
2. Um die Tests durchführen zu können, müssen Testdaten vorliegen. Diese sollen in den jeweiligen Fixtures definiert werden.

### Eine kleine Anmerkung

Die Methodik der testgetriebenen Entwicklung (TDD) entstammt der agilen Softwareentwicklung und dort Vorgehensmodellen wie Extreme Programming (XP). In der agilen Softwareentwicklung wird oft auf eine formale Spezifikation des Systems verzichtet, um schnell auf Änderungen reagieren zu können. Dies bedeutet jedoch nicht, dass überhaupt keine Spezifikation existiert! Die automatischen Tests bilden hier die Spezifikation. Daher ist es auch notwendig die Tests vor der eigentlichen Entwicklung zu schreiben. Sie definieren, wie eine Spezifikation, den Funktionsumfang der zu implementierenden Teile des Systems. Daher kommt die Aussage, dass Code der nicht getestet ist, auch nicht existiert.

## Ressourcen

* http://api.rubyonrails.com/
* Ruby Test Cheat Sheet

## Shortcuts

### Testarten

* **Unit-Tests:** Testen Funktionalitäten auf Modellebene. Hier wird immer nur eine Modellklasse selbst getestet. Dazu zählen aber auch ob Relationen zwischen Modellen funktionieren.
* **Functional-Tests:** Testen ob die Controllerebene wie erwartet funktioniert. Ob Parameter richtig verarbeitet und die richtigen Objekte instanziiert werden, sind Fragen die hier beantwortet werden müssen. Ein Viewtesting ist hier nur sehr rudimentär möglich. In einem Functionaltest wird immer nur ein Controller getestet.
* **Integration-Tests:** Testen Abläufe innerhalb der Applikation. Hier werden verschiedene Controller im Zusammenspiel getestet. Es lässt sich simulieren wie sich ein Benutzer in der Applikation bewegt. Aber auch hier ist View-Testing nur rudimentär möglich.

### Testcases

* Die Klassen der Testcases befinden sich im Ordner <code>test</code> und dort in den entsprechenden Unterordnern.
* Die Datei <code>test_helper.rb</code> wird von allen Tests geladen. Hier werden allgemeine Einstellungen vorgenommen (wie alle Fixtures zu laden und wie Fixtures geladen werden) und das Environment auf <code>test</code> gesetzt.
* Die Tests vererben von <code>Test::Unit::TestCase</code> (Unittests) oder <code>ActionController::TestCase</code>(Functionaltests, vererbt selbst aber auch von <code>Test::Unit::TestCase
</code>). Dadurch sind zwei Methoden verfügbar, die überschrieben werden können: <code>setup</code> und <code>teardown</code>. Diese Methoden beinhalten Anweisungen, die vor bzw. nach jedem Test (also jeder Testmethode) auszuführen sind.
* Testmethoden beginnen immer mit <code>test_</code>, ansonsten werden sie nicht beim Testlauf ausgeführt.

### Assertions

* siehe Cheat Sheet (die <code>Test::Rails</code> Assertions sind nicht verfügbar)
* Zusätzlich ist noch die Assertion <code>assert_difference(object, modifier, &block)</code> verfügbar, bzw. <code>assert_no_difference</code>

### Fixtures

* In den Fixturesdateien zu jeder Modellklasse sind die Testdaten in YAML Notation spezifiziert. Sie entsprechen einer Art Objektserialisierung und daher können die selben Methodennamen verwendet werden, wie beim Erzeugen eines Objekts im Programm. Zu beachten ist, dass die Einrückungen in einer YAML Datei Leerzeichen sein müssen und keine Tabs (TextMate verwendet immer *SoftTabs*, setzt also Leerzeichen wenn man die Tabulatortaste drückt).
* Innerhalb der Tests kann auf die Testdaten über eine Methode die wie die Fixturedatei heisst zugegriffen werden, mit dem Namen des Datensatzes als Parameter (Bsp.: <code>articles(:article_for_test)</code>)

Beispiel:

<pre><code>
# Dieser Datensatz muss in der test/fixtures/articles.yml Datei stehen
# Auch gelten ganz normale Kommentare
article_for_test: # Name des Datensatzes
  title: Article for Pagination test
  author: dirk # Referenz auf einen Datensatz in der authors.yml Datei
  content: Lorem ipsum dolor sit amet, consectetur 
  created_at: <%= 5.days.ago.to_formatted_s(:db) %> # Fixtures durchlaufen auch den ERB Parser!
</code></pre>

### Ausführen der Tests

* <code>rake test:units</code> - Führt alle Unit Tests aus
* <code>rake test:functionals</code> - Führt alle Functional Tests aus
* <code>rake test:integration</code> - Führt alle Functional Tests aus
* <code>rake test</code> - Führt alle Tests aus

### Beispiel

<pre><code>
def test_should_have_valid_title
  article = Article.new(:title => '', :author => users(:jessie))
  assert !article.valid?
  assert article.errors.invalid?(:title)
  article.title = "Test Title"
  assert article.save
end
</code></pre>  