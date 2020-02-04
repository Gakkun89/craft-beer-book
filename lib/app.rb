# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sqlite3'
require 'sinatra/activerecord'
require_relative 'models/beer'

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

post '/madd' do
  @beer = params
  Beer.create(name: params[:name],
              brewery: params[:brewery],
              abv: params[:abv],
              style: params[:style],
              notes: params[:notes],
              uscore: params[:uscore],
              img: params[:img])
  redirect "/"
  erb :mconfirm
end

# -- TODO --
# Add confirmation screen to adding beers?
# Nav bar in layout? - click for options, add etc
# Create a Scraper class to get the data from BA (models?)
# Research how to scrape images, save them and then reference them in the DB
