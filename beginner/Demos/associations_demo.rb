# Article und seine Objekte

article = Article.find(:first)

# Ein Article hat einen Author vom Typ User
article.author
article.author.class

# Ein Artikel kann auch viele Kommentare haben
article.comments
# Davon der erste ...
comment = article.comments.first
# ... hat den gleichen Article
comment.article == article

# Ein Artikel hat hier auch noch viele Tags
article.tags
# und hier nehm ich mir einen Tag ...
tag = article.tags.first
# ... und der hat dann viele Artikel
tag.articles

# Aber ein Kommentar kann nicht ohne Article ezistieren ...
comment = Comment.new(:email => "dirk.breuer@gmail.com", :author => "Dirk Breuer")
comment.valid?
comment.errors.invalid?(:article_id)
# Aber es muss den Artikel auch geben!
comment = Comment.new(:email => "dirk.breuer@gmail.com", :author => "Dirk Breuer", :article_id => -23)
comment.valid?
comment.errors.invalid?(:article)

# Dymanische Methoden werden den assoziierten Objekten hinzugefügt ...
comment = article.comments.build(:email => "dirk.breuer@gmail.com", :author => "Dirk Breuer")
# Das hat dann direkt den richtigen Article
comment.article
# Geht auch wieder mit create
comment = article.comments.create(:email => "dirk.breuer@gmail.com", :author => "Dirk Breuer")

# Find Methoden auf den assoziierten Objekten
article.comments.find(:all, :conditions => ['author = ?', 'Jessie Summers'])
# Sucht nur in der Kommentaren die zu dem Artikel gehören

# Ich kann auch Daten löschen
article.comments.delete_all # löscht alles per SQL
article.comments.destroy_all # löscht alles, aber instanziiert alle Objekte vorher

article.comments.destroy(1)
article.comments.delete(article.comments.last)
article.comments.first.destroy