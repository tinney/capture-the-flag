require 'net/http'
require 'uri'
require 'json'
require 'pry'


#TEAM_ID = "YOUR TEAM ID"

# BASE_URL = "https://capture-the-flag.herokuapp.com/"
BASE_URL = "http://localhost:3000/api"

PLAYER_ID = "1"
PLAYER_NAME = 'Dustin Tinney'

#PLAYER_ID = "2"
#PLAYER_NAME = 'Jennifer Konikowski'

HEADERS = {'Content-Type' =>'application/json', 'PLAYER' => PLAYER_ID, 'PLAYER_NAME' => PLAYER_NAME}

def make_request(api_endpoint, request_body)
  uri = URI.parse("#{BASE_URL}/#{api_endpoint}/")
  http = Net::HTTP.new(uri.host, uri.port)

  req = Net::HTTP::Post.new(uri.path, HEADERS)
  req.body = request_body.to_json
  res = http.request(req)

  return JSON.parse(res.body)

  rescue => e
    puts "failed #{e}"
end

def calcuclate_direction(x:, y:, response:)
  puts response
  return ["SOUTH", "EAST", "NORTH", "WEST"].sample
end

def get_direction
  puts "Pick a direction: n,s,e,w"
  gets.chomp
end

puts "Playing the game"
puts "Moving the player around"

directions = { s: "SOUTH", e: "EAST", n: "NORTH", w: "WEST", j: 'JUNK' } 

while direction = get_direction do
  puts "Moving #{direction}"
  response = make_request("moves", { direction: directions[direction.to_sym] })
  puts response
end
# 10.times do
#   response = []
#   direction = calcuclate_direction(x: response["player"]["x"], y: response["player"]["y"], response: response)
#   sleep(1)
# end
