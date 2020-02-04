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

get '/mconfirm' do
  @beer = params
  Beer.create(name: params[:name],
              brewery: params[:brewery],
              abv: params[:abv],
              style: params[:style],
              notes: params[:notes],
              score: params[:uscore],
              img: params[:img])
  erb :mconfirm
end

post '/mconfirm' do
  @beer = params
  erb :mconfirm
end

# -- TODO --
# Sort out active record with the rakefile and making a db with migration etc
# Implement a way to manually add beers
# Work our logic for dealing with import or manual import
# Use cookies to store beer data before adding to DB? with a check? to display last saved cookie>
# Nav bar in layout? - click for options, add etc
# Create a Scraper class to get the data from BA (models?)
# Research how to scrape images, save them and then reference them in the DB
# Convert to activerecord
