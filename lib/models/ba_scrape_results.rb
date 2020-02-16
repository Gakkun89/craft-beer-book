require "nokogiri"
require "open-uri"

class BAScraperResults
  def initialize(query)
    # @url = "https://www.beeradvocate.com/search/?q=#{query}"
    @url = "lib/models/notfound.html"
    @doc = Nokogiri::HTML(open(@url))
    @names = []
    @descriptions = []
    @beer_profiles = []
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
    check_for_results
  end

  # Check if there are any results
  def check_for_results
    if @names[0] == "You can also try results from Google..."
      return {
        beer_1: {
          name: "Sorry no results found on BA",
          brewery: "",
          style: "",
          url: ""
        }
      }
    end
    create_result_hash
  end

  # Create a hash of results with number then beer name, brewery, style and url info

  def create_result_hash
    beer_profiles
    {
      beer_1: {
        name: @names[0],
        brewery: @descriptions[0],
        style: @descriptions[1],
        url: @profiles[0]
      },
      beer_2: {
        name: @names[1],
        brewery: @descriptions[2],
        style: @descriptions[3],
        url: @profiles[1]
      },
      beer_3: {
        name: @names[2],
        brewery: @descriptions[4],
        style: @descriptions[5],
        url: @profiles[2]
      },
      beer_4: {
        name: @names[3],
        brewery: @descriptions[6],
        style: @descriptions[7],
        url: @profiles[3]
      },
      beer_5: {
        name: @names[4],
        brewery: @descriptions[8],
        style: @descriptions[9],
        url: @profiles[4]
      }
    }
  end
  # Get the url endings for each beer to make image scraping etc easier
  def beer_profiles
    @profiles = []
    @raw_profiles = @doc.xpath('//div/a/@href')[5..14].map { |text| text.text.strip }
    @raw_profiles.each do |link|
      @profiles << link.split('/')[4]
    end
    @profiles = @profiles.uniq
  end
end

p BAScraperResults.new("lol").search_title_scrape
