require "sinatra"
require "sinatra/reloader" if development?
require "json"
require "pry" 
require 'faraday'

set :bind, '0.0.0.0'  # bind to all interfaces
set :public_folder, File.join(File.dirname(__FILE__), "public")

CLIENT_ID = "94132ae1e67e4e89874701ce5412293d"
CLIENT_SECRET = "94d168ad09484825917bc07a9ae213de"

def encode(args)
  return URI.escape(args, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
end

get "/" do
  response = Faraday.post("https://accounts.spotify.com/api/token",
    grant_type: "authorization_code", 
    code: params["code"], 
    redirect_uri: "http://localhost:4567", 
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET
  )
  @@responseData = JSON.parse(response.body)
  erb :home
end

get "/Login" do
  scopes = 'user-read-private user-read-email, streaming'
  redirect_uri = 'http://localhost:4567'
  redirect('https://accounts.spotify.com/authorize' +
  '?response_type=code' +
  '&client_id=' + CLIENT_ID +
  (scopes ? '&scope=' + encode(scopes) : '') +
  '&redirect_uri=' + encode(redirect_uri));
end

get "/api/v1/Login" do
  JSON(@@responseData)
end