require "nokogiri"
require "open-uri"

class BAScrapeProfile
  def initialize(url)
    @url = "https://www.beeradvocate.com/beer/shelf-talker/?b=#{url}"
    @doc = Nokogiri::HTML(open(@url))
    @rawbeer = []
    @beer = {
      name: '',
      brewery: '',
      abv: 0.0,
      style: '',
      bascore: ''
    }
  end

  def scrape
    @doc.search('tr').each do |tr|
      @rawbeer << tr.text.strip
    end
    cleaned_text = @rawbeer[2].split("\n")
    @beer = {
      name: cleaned_text[0],
      brewery: cleaned_text[9],
      abv: cleaned_text[7].gsub('%', '').to_f,
      style: cleaned_text[5],
      bascore: cleaned_text[3].delete("^0-9")
    }
  end
end
