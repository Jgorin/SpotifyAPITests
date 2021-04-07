require "sinatra"
require "sinatra/reloader" if development?
require "json"
require "pry" 
require 'faraday'
require 'dotenv/load'

require_relative "./SpotifyWrapper"

set :bind, '0.0.0.0'  # bind to all interfaces
set :public_folder, File.join(File.dirname(__FILE__), "public")

REDIRECT_URI = 'http://localhost:4567/home'

get "/" do
  redirect "/authenticate"
end

get "/authenticate" do
  authenticate('user-read-private user-read-email, streaming', REDIRECT_URI)
end

get "/home" do
  @@userKey = getToken(params["code"], REDIRECT_URI)
  erb :home
end

get "/api/v1/getToken" do
  JSON(@@userKey)
end