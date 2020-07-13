# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

red_team = Team.create!(name: "Red Team")
blue_team = Team.create!(name: "Blue Team")

red_team.place_flag
blue_team.place_flag

Player.create!(name: "Kyle Adams", team: blue_team)
Player.create!(name: "Micah Adams", team: blue_team)
Player.create!(name: "Jason Allen", team: blue_team)
Player.create!(name: "Van Anderson", team: blue_team)
Player.create!(name: "River Bailey", team: blue_team)
Player.create!(name: "Raelyn Bangel", team: blue_team)
Player.create!(name: "Kevin Baribeau", team: blue_team)
Player.create!(name: "Ross Brandes", team: blue_team)
Player.create!(name: "Chris Caragianis", team: blue_team)
Player.create!(name: "Ilana Corson", team: blue_team)
Player.create!(name: "Kerry Diehl", team: blue_team)
Player.create!(name: "Jeremy Fairbank", team: blue_team)
Player.create!(name: "Daniel Flynn", team: blue_team)
Player.create!(name: "Tommy Groshong", team: blue_team)
Player.create!(name: "Jason Grosz", team: blue_team)
Player.create!(name: "Joel Helbling", team: blue_team)
Player.create!(name: "Ali Ibrahim", team: blue_team)
Player.create!(name: "Steve Jackson", team: blue_team)
Player.create!(name: "Sam Jones", team: blue_team)
Player.create!(name: "Nate Kandler", team: blue_team)
Player.create!(name: "Jason Karns", team: blue_team)
Player.create!(name: "Josh Klina", team: blue_team)

Player.create!(name: "Jennifer Konikowski", team: red_team)
Player.create!(name: "Kaleb Lape", team: red_team)
Player.create!(name: "Neal Lindsay", team: red_team)
Player.create!(name: "Adam Lukens", team: red_team)
Player.create!(name: "Alex Martin", team: red_team)
Player.create!(name: "Keith McCanless", team: red_team)
Player.create!(name: "Mark Miranda", team: red_team)
Player.create!(name: "Brittany Ann Moore", team: red_team)
Player.create!(name: "Eric Newbury", team: red_team)
Player.create!(name: "Tom Nightingale", team: red_team)
Player.create!(name: "Dayton Nolan", team: red_team)
Player.create!(name: "Marc Peabody", team: red_team)
Player.create!(name: "Jamie Phelps", team: red_team)
Player.create!(name: "Cliff Pruitt", team: red_team)
Player.create!(name: "Lee Quarella", team: red_team)
Player.create!(name: "Dan Thompson", team: red_team)
Player.create!(name: "Elmar Valmores", team: red_team)
Player.create!(name: "Stephen Vance", team: red_team)
Player.create!(name: "Andy Vida", team: red_team)
Player.create!(name: "Rob Vitaro", team: red_team)
Player.create!(name: "Marla Brizel Zeschin", team: red_team)
