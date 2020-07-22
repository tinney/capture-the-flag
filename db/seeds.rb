# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Game.create!()
left_team = Team.create!(name: "Yellow Team (Left)", field_side: :left_field)
right_team = Team.create!(name: "Green Team (Right)", field_side: :right_field)

left_team.hide_flag!
right_team.hide_flag!

Player.create!(email: 'dustin@testdouble.com', name: "Dustin Tinney", team: left_team, icon: 'D')
Player.create!(email: "kyle@testdouble.com", name: "Kyle Adams", team: left_team, icon: '🥺')
Player.create!(email: "micah@testdouble.com", name: "Micah Adams", team: left_team, icon: '😷')
Player.create!(email: "jason@testdouble.com", name: "Jason Allen", team: left_team, icon: '🧐')
Player.create!(email: "van.anderson@testdouble.com", name: "Van Anderson", team: left_team, icon: '🤯')
Player.create!(email: "river@testdouble.com", name: "River Bailey", team: left_team, icon: '😳')
Player.create!(email: "raelyn@testdouble.com", name: "Raelyn Bangel", team: left_team, icon: '🤗')
Player.create!(email: "kevin@testdouble.com", name: "Kevin Baribeau", team: left_team, icon: '😑')
Player.create!(email: "ross@testdouble.com", name: "Ross Brandes", team: left_team, icon: '😀')
Player.create!(email: "chris@testdouble.com", name: "Chris Caragianis", team: left_team, icon: '😅')
Player.create!(email: "kerry@testdouble.com", name: "Kerry Diehl", team: left_team, icon: '😂')
Player.create!(email: "jeremy@testdouble.com", name: "Jeremy Fairbank", team: left_team, icon: '🤣')
Player.create!(email: "daniel@testdouble.com", name: "Daniel Flynn", team: left_team, icon: '😇')
Player.create!(email: "tommy@testdouble.com", name: "Tommy Groshong", team: left_team, icon: '🙃')
Player.create!(email: "grosz@testdouble.com", name: "Jason Grosz", team: left_team, icon: '😍')
Player.create!(email: "joel@testdouble.com", name: "Joel Helbling", team: left_team, icon: '🥰')
Player.create!(email: "alib@testdouble.com", name: "Ali Ibrahim", team: left_team, icon: '😘')
Player.create!(email: "steve@testdouble.com", name: "Steve Jackson", team: left_team, icon: '😋')
Player.create!(email: "sam@testdouble.com", name: "Sam Jones", team: left_team, icon: '😎')
Player.create!(email: "nate@testdouble.com", name: "Nate Kandler", team: left_team, icon: '🤓')
Player.create!(email: "jason@testdouble.com", name: "Jason Karns", team: left_team, icon: '🤩')
Player.create!(email: "josh@testdouble.com", name: "Josh Klina", team: left_team, icon: '🥳')

Player.create!(email: "jennifer@testdouble.com", name: "Jennifer Konikowski", team: right_team, icon: '💚')
Player.create!(email: "kaleb@testdouble.com", name: "Kaleb Lape", team: right_team, icon: '🥬')
Player.create!(email: "neal@testdouble.com", name: "Neal Lindsay", team: right_team, icon: '🤢')
Player.create!(email: "adam@testdouble.com", name: "Adam Lukens", team: right_team, icon:'🟢')
Player.create!(email: "alex@testdouble.com", name: "Alex Martin", team: right_team, icon:'🟩')
Player.create!(email: "keith@testdouble.com", name: "Keith McCanless", team: right_team, icon:'🥒 ')
Player.create!(email: "mark.miranda@testdouble.com", name: "Mark Miranda", team: right_team, icon: '🐢')
Player.create!(email: "brittany@testdouble.com", name: "Brittany Ann Moore", team: right_team, icon: '🍐')
Player.create!(email: "eric@testdouble.com", name: "Eric Newbury", team: right_team, icon:'🔋')
Player.create!(email: "tom@testdouble.com", name: "Tom Nightingale", team: right_team, icon:'🎋')
Player.create!(email: "dayton@testdouble.com", name: "Dayton Nolan", team: right_team, icon:'🚛')
Player.create!(email: "marc@testdouble.com", name: "Marc Peabody", team: right_team, icon:'🥗')
Player.create!(email: "jamie@testdouble.com", name: "Jamie Phelps", team: right_team, icon:'📗')
Player.create!(email: "cliff@testdouble.com", name: "Cliff Pruitt", team: right_team, icon:'🍏')
Player.create!(email: "lee@testdouble.com", name: "Lee Quarella", team: right_team, icon:'🍡')
Player.create!(email: "dan@testdouble.com", name: "Dan Thompson", team: right_team, icon:'🦕')
Player.create!(email: "elmar@testdouble.com", name: "Elmar Valmores", team: right_team, icon: '🦗')
Player.create!(email: "stephen@testdouble.com", name: "Stephen Vance", team: right_team, icon:'🌵')
Player.create!(email: "andy@testdouble.com", name: "Andy Vida", team: right_team, icon:'🐍')
Player.create!(email: "rob@testdouble.com", name: "Rob Vitaro", team: right_team, icon:'🥦')
Player.create!(email: "marla@testdouble.com", name: "Marla Brizel Zeschin", team: right_team, icon:'🩲')