require 'faraday'

def encode(args)
  return URI.escape(args, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
end

def authenticate(scopes, redirect_uri)
  redirect('https://accounts.spotify.com/authorize' +
  '?response_type=code' +
  '&client_id=' + ENV["CLIENT_ID"] +
  (scopes ? '&scope=' + encode(scopes) : '') +
  '&redirect_uri=' + encode(redirect_uri));
end

def getToken(auth_code, redirect_link)
  response = Faraday.post("https://accounts.spotify.com/api/token",
    grant_type: "authorization_code", 
    code: auth_code, 
    redirect_uri: redirect_link, 
    client_id: encode(ENV["CLIENT_ID"]),
    client_secret: encode(ENV["CLIENT_SECRET"])
  )
  return JSON.parse(response.body)
end