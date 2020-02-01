# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sqlite3'

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/craft-beer-book'))
DB.results_as_hash = true
get '/' do
  @beers = DB.execute('SELECT id, name, brewery FROM beers')
  erb :home
end

get '/beers/:id' do
  @beer = DB.execute('SELECT * FROM beers WHERE id = ? ', params[:id])[0]
  erb :beers
end

get '/add' do


  erb :add
end

# -- TODO --
# Implement a way to manually add beers
# Work our logic for dealing with import or manual import
# Nav bar in layout? - click for options, add etc
# Create a Scraper class to get the data from BA (models?)
# Research how to scrape images, save them and then reference them in the DB
