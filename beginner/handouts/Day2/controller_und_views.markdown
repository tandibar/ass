# Tag 2, Hands-On 6: Controller und Views

## Ziel des Hands-on

1. Relationen auch auf der Controller und View Ebene umsetzen können.
2. Die ActiveRecord Methode <code>find</code> und <code>update</code> näher kennen lernen

## Aufgabe

1. Die Relationen zwischen den Modellen haben Auswirkungen auf die Präsentations -und Controllerlogik. Deswegen müssen die Controller und View-Elemente angepasst werden. Aus der Einzelansicht eines Artikels sollte die Möglichkeit gegeben werden Kommentare zu einem Artikel anzuzeigen und neue Kommentare für diesen Artikel hinzuzufügen.
2. Die <code>ActiveRecord</code> Methoden <code>find</code> und <code>update</code> dienen als Abstraktionsmethoden für Datenbankoperationen. Es soll mittels der Methode <code>find</code> verschiedene Abfragen getätigt werden, die Auswirkungen auf die Artikel haben.

## Ressourcen

* http://api.rubyonrails.com/classes/ActionController/Base.html
* http://api.rubyonrails.com/classes/ActionView/Base.html
* http://ar.rubyonrails.org/classes/ActiveRecord/Base.html

## Shortcuts

### Informationen zu der 1. Aufgabe

* Das Template zur Einzelansicht eines Artikels befindet sich in (app/views/articles/show.rhml)
* Ein Template zur Auflisten alle Kommentare sollte implementiert werden.
* Ein Template zum Anlegen eines Kommentar sollte implementiert werden.
* Der Zugriff der Kommentar-Templates sollte über die Einzelansicht eines Artikels erfolgen.
* Die zugehörigen Actions sollten sinnvoll benannt und an geeigneter Stelle implementiert werden.

**Wichtige Methoden im Controller:**

  <pre><code>
  def show
    # Wertüberhabe über die params Methode
    @article = Article.find(params[:id])
  end</code></pre>

* Templates innerhalb einer Action rendern oder an andere Actions redirecten
  * <code>render :template => 'name'</code>
  * <code>redirect_to :action => 'name'</code>

**Wichtige Methoden in der View:**

* <code><% form_for :comment, @comment do |f| %></code>
* <code><%= f.text_field :author %></code>
* <code><%= submit_tag 'Save' %></code>
* <code><%= link_to 'Edit', edit_article_path %></code>
* <code><%= h @article.title %></code>

### Informationen zu der 2. Aufgabe

* Auf der Startseite des Blogs werden bestimmte Artikel angezeigt. 
  * Es sollen die letzten 10 aktuellsten Artikel in der Liste ausgegeben werden.  
  * Es sollen alle Artikel vom **heutigen Tag** ausgegeben werden. (Link auf der Startseite "Artikel von Heute")
  * Es sollen alle Artikel vom **gestrigen Tag** ausgegeben werden. (Link auf der Startseite "Artikel von Gestern")
  * Es sollen alle Artikel der **die älter** sind ausgegeben werden. (Link auf der Startseite "Artikel von letzter Woche")
  
* Find by id
  * <code>Person.find(1)        # returns the object for ID = 1</code>
  * <code>Person.find(1, 2, 6)  # returns an array for objects with IDs in (1, 2, 6)</code>
  * <code>Person.find([7, 17])  # returns an array for objects with IDs in (7, 17)</code>
  * <code>Person.find([1])      # returns an array for objects the object with ID = 1</code>
  * <code>Person.find(1, :conditions => "administrator = 1",  :order => "created_on DESC")</code>
* Find first
  * <code>Person.find(:first)  # returns the first object fetched by  SELECT * FROM people</code>
  * <code>Person.find(:first,  :conditions => [ "user_name = ?", user_name])</code>
  * <code>Person.find(:first, :order => "created_on DESC",:offset => 5) </code>
* Find all
  * <code>Person.find(:all)  # returns an array of objects for all the rows fetched by SELECT * FROM people</code>
  * <code>Person.find(:all, :conditions => [ "category IN (?)",  categories], :limit => 50)</code>
  * <code>Person.find(:all, :offset => 10, :limit => 10)</code>
  * <code>Person.find(:all, :include => [ :account, :friends ])</code>
  * <code>Person.find(:all, :group => "category")</code>