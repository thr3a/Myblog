xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Myblog::Application.config.title
    xml.description Myblog::Application.config.description
    xml.link root_url

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.content
      end
    end
  end
end
