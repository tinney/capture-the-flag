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

Player.create!(active: false, email: 'dustin@testdouble.com', name: "Dustin Tinney", team: left_team, icon: 'DT')
Player.create!(active: false, email: "kyle@testdouble.com", name: "Kyle Adams", team: left_team, icon: '🥺')
Player.create!(active: false, email: "micah@testdouble.com", name: "Micah Adams", team: left_team, icon: '😷')
Player.create!(active: false, email: "jason@testdouble.com", name: "Jason Allen", team: left_team, icon: '🧐')
Player.create!(active: false, email: "van.anderson@testdouble.com", name: "Van Anderson", team: left_team, icon: '🤯')
Player.create!(active: false, email: "river@testdouble.com", name: "River Bailey", team: left_team, icon: '😳')
Player.create!(active: false, email: "raelyn@testdouble.com", name: "Raelyn Bangel", team: left_team, icon: '🤗')
Player.create!(active: false, email: "kevin@testdouble.com", name: "Kevin Baribeau", team: left_team, icon: '😑')
Player.create!(active: false, email: "ross@testdouble.com", name: "Ross Brandes", team: left_team, icon: '😀')
Player.create!(active: false, email: "chris@testdouble.com", name: "Chris Caragianis", team: left_team, icon: '😅')
Player.create!(active: false, email: "kerry@testdouble.com", name: "Kerry Diehl", team: left_team, icon: '😂')
Player.create!(active: false, email: "jeremy@testdouble.com", name: "Jeremy Fairbank", team: left_team, icon: '🤣')
Player.create!(active: false, email: "daniel@testdouble.com", name: "Daniel Flynn", team: left_team, icon: '😇')
Player.create!(active: false, email: "tommy@testdouble.com", name: "Tommy Groshong", team: left_team, icon: '🙃')
Player.create!(active: false, email: "grosz@testdouble.com", name: "Jason Grosz", team: left_team, icon: '😍')
Player.create!(active: false, email: "joel@testdouble.com", name: "Joel Helbling", team: left_team, icon: '🥰')
Player.create!(active: false, email: "alib@testdouble.com", name: "Ali Ibrahim", team: left_team, icon: '😘')
Player.create!(active: false, email: "steve@testdouble.com", name: "Steve Jackson", team: left_team, icon: '😋')
Player.create!(active: false, email: "sam@testdouble.com", name: "Sam Jones", team: left_team, icon: '😎')
Player.create!(active: false, email: "nate@testdouble.com", name: "Nate Kandler", team: left_team, icon: '🤓')
Player.create!(active: false, email: "jason@testdouble.com", name: "Jason Karns", team: left_team, icon: '🤩')
Player.create!(active: false, email: "josh@testdouble.com", name: "Josh Klina", team: left_team, icon: '🥳')

Player.create!(active: false, email: "jennifer@testdouble.com", name: "Jennifer Konikowski", team: right_team, icon: '💚')
Player.create!(active: false, email: "kaleb@testdouble.com", name: "Kaleb Lape", team: right_team, icon: '🥬')
Player.create!(active: false, email: "neal@testdouble.com", name: "Neal Lindsay", team: right_team, icon: '🤢')
Player.create!(active: false, email: "adam@testdouble.com", name: "Adam Lukens", team: right_team, icon:'🟢')
Player.create!(active: false, email: "alex@testdouble.com", name: "Alex Martin", team: right_team, icon:'🟩')
Player.create!(active: false, email: "keith@testdouble.com", name: "Keith McCanless", team: right_team, icon:'🥒 ')
Player.create!(active: false, email: "mark.miranda@testdouble.com", name: "Mark Miranda", team: right_team, icon: '🐢')
Player.create!(active: false, email: "brittany@testdouble.com", name: "Brittany Ann Moore", team: right_team, icon: '🍐')
Player.create!(active: false, email: "eric@testdouble.com", name: "Eric Newbury", team: right_team, icon:'🔋')
Player.create!(active: false, email: "tom@testdouble.com", name: "Tom Nightingale", team: right_team, icon:'🎋')
Player.create!(active: false, email: "dayton@testdouble.com", name: "Dayton Nolan", team: right_team, icon:'🚛')
Player.create!(active: false, email: "marc@testdouble.com", name: "Marc Peabody", team: right_team, icon:'🥗')
Player.create!(active: false, email: "jamie@testdouble.com", name: "Jamie Phelps", team: right_team, icon:'📗')
Player.create!(active: false, email: "cliff@testdouble.com", name: "Cliff Pruitt", team: right_team, icon:'🍏')
Player.create!(active: false, email: "lee@testdouble.com", name: "Lee Quarella", team: right_team, icon:'🍡')
Player.create!(active: false, email: "dan@testdouble.com", name: "Dan Thompson", team: right_team, icon:'🦕')
Player.create!(active: false, email: "elmar@testdouble.com", name: "Elmar Valmores", team: right_team, icon: '🦗')
Player.create!(active: false, email: "stephen@testdouble.com", name: "Stephen Vance", team: right_team, icon:'🌵')
Player.create!(active: false, email: "andy@testdouble.com", name: "Andy Vida", team: right_team, icon:'🐍')
Player.create!(active: false, email: "rob@testdouble.com", name: "Rob Vitaro", team: right_team, icon:'🥦')
Player.create!(active: false, email: "marla@testdouble.com", name: "Marla Brizel Zeschin", team: right_team, icon:'🩲')