# Setup

* bundle install
* db:seed if you would like player information 
* brew install anycable-go for the socket connection

## Running Locally

To run the anycable server use anycable-go which can be brew installed
Run the following 3 commands: 

* anycable-go --host=localhost --port=8080 
* bundle exec anycable
* bin/rails s
* be ruby bin/play_game.rb #to play the game



You can go here http://td-capture-the-flag.herokuapp.com/ to get a view of the board. Check the capture-the-flag-client-{rb|js} for more info on how to move. 



## Where to get the Gem

We have provide a ruby gem and a javascript package you can use to move your player around on the field to capture the other teams flag while keeping them from capturing yours.   

* Ruby: https://github.com/danthompson/capture-the-flag-client-rb
* JavaScript: https://github.com/danthompson/capture-the-flag-client-js
* Go:  (╯°□°）╯︵ ┻━┻ 



## Setup Your Player (via your browser)

1. Go to http://td-capture-the-flag.herokuapp.com/teams

2. Find your name from the list Edit

   1. Verify/Update your Name and Email

   2. Change your Icon if you would like (teams have icon themes Team Yellow and Team Green)

   3. Choose your Ability 

      1. Sight - You can see twice as far in the game 
      2. Agility - You have a better chance of dodging a players peg and flag grab (more info below)

   4. Activate your player  