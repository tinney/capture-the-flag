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

Player.create!(name: "Dustin Tinney", team: left_team, icon: '🥺')
# Player.create!(name: "Kyle Adams", team: left_team, icon: '🥺')
# Player.create!(name: "Micah Adams", team: left_team, icon: '😷')
# Player.create!(name: "Jason Allen", team: left_team, icon: '🧐')
# Player.create!(name: "Van Anderson", team: left_team, icon: '🤯')
# Player.create!(name: "River Bailey", team: left_team, icon: '😳')
# Player.create!(name: "Raelyn Bangel", team: left_team, icon: '🤗')
# Player.create!(name: "Kevin Baribeau", team: left_team, icon: '😑')
# Player.create!(name: "Ross Brandes", team: left_team, icon: '😀')
# Player.create!(name: "Chris Caragianis", team: left_team, icon: '😅')
# Player.create!(name: "Kerry Diehl", team: left_team, icon: '😂')
# Player.create!(name: "Jeremy Fairbank", team: left_team, icon: '🤣')
# Player.create!(name: "Daniel Flynn", team: left_team, icon: '😇')
# Player.create!(name: "Tommy Groshong", team: left_team, icon: '🙃')
# Player.create!(name: "Jason Grosz", team: left_team, icon: '😍')
# Player.create!(name: "Joel Helbling", team: left_team, icon: '🥰')
# Player.create!(name: "Ali Ibrahim", team: left_team, icon: '😘')
# Player.create!(name: "Steve Jackson", team: left_team, icon: '😋')
# Player.create!(name: "Sam Jones", team: left_team, icon: '😎')
# Player.create!(name: "Nate Kandler", team: left_team, icon: '🤓')
# Player.create!(name: "Jason Karns", team: left_team, icon: '🤩')
# Player.create!(name: "Josh Klina", team: left_team, icon: '🥳')

Player.create!(name: "Jennifer Konikowski", team: right_team, icon: '💚')
# Player.create!(name: "Kaleb Lape", team: right_team, icon: '🥬')
# Player.create!(name: "Neal Lindsay", team: right_team, icon: '🤢')
# Player.create!(name: "Adam Lukens", team: right_team, icon:'🟢')
# Player.create!(name: "Alex Martin", team: right_team, icon:'🟩')
# Player.create!(name: "Keith McCanless", team: right_team, icon:'🥒 ')
# Player.create!(name: "Mark Miranda", team: right_team, icon: '🐢')
# Player.create!(name: "Brittany Ann Moore", team: right_team, icon: '🍐')
# Player.create!(name: "Eric Newbury", team: right_team, icon:'🔋')
# Player.create!(name: "Tom Nightingale", team: right_team, icon:'🎋')
# Player.create!(name: "Dayton Nolan", team: right_team, icon:'🚛')
# Player.create!(name: "Marc Peabody", team: right_team, icon:'🥗')
# Player.create!(name: "Jamie Phelps", team: right_team, icon:'📗')
# Player.create!(name: "Cliff Pruitt", team: right_team, icon:'🍏')
# Player.create!(name: "Lee Quarella", team: right_team, icon:'🍡')
# Player.create!(name: "Dan Thompson", team: right_team, icon:'🦕')
# Player.create!(name: "Elmar Valmores", team: right_team, icon: '🦗')
# Player.create!(name: "Stephen Vance", team: right_team, icon:'🌵')
# Player.create!(name: "Andy Vida", team: right_team, icon:'🐍')
# Player.create!(name: "Rob Vitaro", team: right_team, icon:'🥦')
# Player.create!(name: "Marla Brizel Zeschin", team: right_team, icon:'🩲')