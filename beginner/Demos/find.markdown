= find

Article
Article.find(:first)
Article.find(:all)
Article.find(:all).size
Article.count
Article.find([100,112,705])
Article.find(100,112,705)
Article.find(100)
Article.find([100])

Article.find(:first, :conditions => ["title = 'Article for Pagination test'"])

Article.find(:all, :conditions => ["title = 'Article for Pagination test'"])

Article.find(:all, :conditions => ["title = 'Article for Pagination test'"]).each { |a| p a.title };nil

Article.find(:all, :conditions => ["title = 'Article for Pagination test'"], :order => 'created_at').each { |a| p a.created_at };nil

<!-- Article.find(:first, :include => :author).author -->
<!-- Article.find(:first).author -->

Article.find_by_title("Article for Pagination test")
Article.find_all_by_title("Article for Pagination test")

Article.find_by_user_id(1)
Article.find_all_by_user_id(2)

Article.find_by_sql("SELECT * FROM articles WHERE user_id = 1")


= New und Create

a = Article.new
a.title = ‘New Article’
a.content = ‘bla bla bla’
a.id
a.new_record?
a.save
a.errors.full_messages
a.author = User.find(:first)
a.user_id

a = Article.create(:title => "Article create", :content => "wieder nix sinnvolles", :author => User.find(:first))
a.id
a.new_record?


= Update

a = Article.find(:first)
a.title
a.title = "Ne Title"
Article.find(:first)
a.save

a.update_attributes(:title => "Just another new title", :content => "bla bla 2")
a.update_attributes(:title => "Just another new title", :content => "bla bla 2", :author => nil)
a.reload

Article.update(1, :title => "Really new")
Article.update(1, {:title => "Really new", :content => "blub blub"})