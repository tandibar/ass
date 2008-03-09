xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Articles"
    xml.description "Recent 10 Articles"
    xml.link formatted_articles_url(:rss)
    
    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.content
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.author article.author.full_name
        xml.link formatted_article_url(article, :html)
      end
    end
  end
end