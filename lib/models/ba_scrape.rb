require "nokogiri"
require "open-uri"

class BAScrape
  def initialize(query)
    @url = "https://www.beeradvocate.com/search/?q=#{query}"
    @doc = Nokogiri::HTML(open("search.html"))
    @names = []
    @descriptions = []
  end

  def search_title_scrape
    @doc.search('b')[2..6].each do |name|
      @names << name.text
    end
    search_description_scrape
  end

  def search_description_scrape

  end
end
scrape = BAScrape.new("lol")
scrape.search_title_scrape
