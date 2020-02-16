# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sqlite3'
require 'sinatra/activerecord'
require_relative 'models/beer'
require_relative 'models/ba_scrape_results'
require_relative 'models/ba_scrape_profile'

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/craft-beer-book'))
DB.results_as_hash = true
get '/' do
  @beers = Beer.all.order(name: :asc)
  erb :home
end

get '/beers/:id' do
  @beer = Beer.find(params[:id])
  erb :beers
end

get '/add' do
  erb :add
end

get '/searchresults' do
  @query = params["query"]
  @results = BAScraperResults.new(@query).search_title_scrape
  erb :searchresults
end

get '/add_ba/:id' do
  @url = params[:id]
  @beer = BAScrapeProfile.new(@url).scrape

  erb :add_ba
end

post '/add_ba/:id' do
  @beer = params
  Beer.create(
    name: params[:name],
    brewery: params[:brewery],
    abv: params[:abv],
    style: params[:style],
    bascore: params[:bascore],
    notes: params[:notes],
    uscore: params[:uscore],
    img: params[:id]
  )
  redirect "/"
end

post '/madd' do
  @beer = params
  Beer.create(name: params[:name],
              brewery: params[:brewery],
              abv: params[:abv],
              style: params[:style],
              notes: params[:notes],
              uscore: params[:uscore],
              img: "nil")
  redirect "/"
end

get '/delete/:id' do
  Beer.destroy(params[:id])
  redirect "/"
end

# -- TODO --
# Handle non existing beers on scrape and less than 5 results
# Add clickable breweries which return all the beers by that brewery
# Research how to save images and then reference them in the DB
