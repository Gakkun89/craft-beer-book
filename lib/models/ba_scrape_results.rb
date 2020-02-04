require "nokogiri"
require "open-uri"

class BAScraperResults
  def initialize(query)
    @url = "https://www.beeradvocate.com/search/?q=#{query}"
    @doc = Nokogiri::HTML(open(@url))
    @names = []
    @descriptions = []
  end
  # Retrieve top 5 search result beer names
  # No obvious tagging so have to use  tag
  def search_title_scrape
    @doc.search('b')[2..6].each do |name|
      @names << name.text
    end
    search_description_scrape
  end
  # Retrieve brewery name and style
  # Containted within a tag so able to scrape

  def search_description_scrape
    @doc.search('.muted a').first(10).each do |description|
      @descriptions << description.text
    end
    create_result_hash
  end
  # Create a hash of results with number then beer name, brewery, style

  def create_result_hash
    {
      beer_1: {
        name: @names[0],
        brewery: @descriptions[0],
        style: @descriptions[1]
      },
      beer_2: {
        name: @names[1],
        brewery: @descriptions[2],
        style: @descriptions[3]
      },
      beer_3: {
        name: @names[2],
        brewery: @descriptions[4],
        style: @descriptions[5]
      },
      beer_4: {
        name: @names[3],
        brewery: @descriptions[6],
        style: @descriptions[7]
      },
      beer_5: {
        name: @names[4],
        brewery: @descriptions[8],
        style: @descriptions[9]
      }
    }
  end
end
