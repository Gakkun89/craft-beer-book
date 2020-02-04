require "nokogiri"
require "open-uri"

class BAScrapeProfile
  def initialize(url)
    @url = "beertalker.html"
    @doc = Nokogiri::HTML(open(@url))
  end

# TODO scrape all dd from the beer talker, then return img url from profile send all back as hash
end
BAScrapeProfile.new("lol")
# consider shelf talker for easy scrape: https://www.beeradvocate.com/beer/shelf-talker/?b=97563
# get img from main page
