require 'net/http'
require 'uri'
require 'json'
require 'pry'

#TEAM_ID = "YOUR TEAM ID"

# BASE_URL = "https://capture-the-flag.herokuapp.com/"
BASE_URL = "http://localhost:3000/api"
TEAM_ID = "24"
HEADERS = {'Content-Type' =>'application/json', 'TEAM' => TEAM_ID }

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

def calcuclate_direction(x:, y:, board:)
  if board.empty? # If there is nothing lets head either North or East
    puts "No Resources heading either East or South"
    return ["SOUTH", "EAST"].sample
  end

  puts "Found resources"
  resource = board.first
  puts resource

  if resource['x'] == x # Resource is above or below us
    if resource['y'] > y
      "SOUTH"
    else
      "NORTH"
    end
  else
    if resource['x'] > x
      "EAST"
    else
      "WEST"
    end
  end
end

puts "Playing the game"
response = make_request("players", {name: "Player w/ EQ Stats", water_stat: 5, food_stat: 5, stamina_stat: 5, strength_stat: 5})
puts response
sleep(3)

puts "Moving the player around"

10.times do
  direction = calcuclate_direction(x: response["player"]["x"], y: response["player"]["y"], board: response["board"])
  response = make_request("moves", { direction: direction })
  puts "Moving #{direction}"
  sleep(1)
end
