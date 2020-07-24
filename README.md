# 💚 2020 Test Double Capture the Flag



## Object of the game

The object of the game is to earn the most points as a team before the end of the retreat day. There will be an offical timer posted in the #capture-the-flag retreat channel so Ilana & Kevin can't cheat this time. 



## How to Play

We have provide a ruby gem and a javascript package you can use to control your player on the field.  

* Ruby: https://github.com/danthompson/capture-the-flag-client-rb
* JavaScript: https://github.com/danthompson/capture-the-flag-client-js
* Go:  (╯°□°）╯︵ ┻━┻ 



## Setup

1. Go to http://td-capture-the-flag.herokuapp.com/teams

2. Activate your player

   1. Verify your Name and Email

   2. Change your Icon if you would like (teams have icon themes Team Yellow and Team Green)

   3. Choose your Ability 

      1. Sight - You can see twice as far in the game 
      2. Agility - You have a better chance of dodging a players peg and flag grab (more info below)
      3. Healthy - You are able to make more moves before needing to take a lie down

   4. Activate your player  

      

## Starting the Game

* Players will start randomly within their base location. 

* Players will start with a peg (more info later)

* Team flag is randomly hidden at the end of each teams base 0 - 5 for the left side base & 75 - 80 for the right side base.

  


## The Field

The Field is a 80x40 grid. The first 5 and last 5 spaces of the field are designated flag zones for each team and can only be entered by the opponents. 

```
Flag Zone          Left Field                        Right Field         Flag Zone
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .
. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .
```



## The Flag

1 flag at a time is randomly placed in each teams flag zone.  Once a flag has been picked up the opposing team the it's location will be known by the opponents team until the flag has been captured.



## Moving

Moving is sent by sending post requests to the move endpoint. Move directions are based on NORTH, SOUTH, EAST, and WEST. You can go here http://td-capture-the-flag.herokuapp.com/ to get a view of the board. 

As developers we get tired easy and need to take a lie down.  Your move response will indicate this by having a `needs_lie_down: X` indicating how long you need to wait until making your next move. 



## Seeing

Players can see in 5 squares around them.  If a player has the sight ability they will be able to see 10 squares around them. 



## Scoring Points

There are many ways to score points for your team. 

* Picking up the flag is worth 5 points

* Capturing another teams flag is worth 25 points. 

* Capturing another players peg is worth 15 points 

* Replacing your own flag from an opponent carrier is worth 30 points

  

  

  ### Capturing the Flag

  To pick up the flag you must leave your base, cross your opponents base to the "flag zone" and find the flag and move onto it's space. Once you have picked up the flag you must travel back across your opponents base past the half way point of the field for a capture.  

  

  You must have a peg in order to pick up the flag. When you have the flag if you enter an opponents square then they will steal it and your peg from you. Players who have agility on have a 30% chance of avoiding the opponent's recapture and moving past. 

  

  Captures are worth 25 points & flag pickups are worth 5 points.  Once a flag is captured a new flag will replace it.

  

  

  ### Capturing a Peg

  To capture an opponents peg you must move to the same space they are on. Peg captures are worth 15 points. A player w/out a peg will glow red on the map. Players who have agility on have a 30% chance of avoiding a peg capture. 

  

  

  ### The Flag Zone

  At the end of each teams base is a 5x40 zone for the flag.  The team cannot enter their own flag zone. This is so you cannot just stand on your own flag to guard it. Once an opponent enters your flag zone they will be safe to find the flag but must recross your base for the capture. 

  

  

  ### Achievements

  There are a random number of achievements each team can be awarded during the game.  Achievement points are based on the difficulty of the achievement and range from 1 point to 100 points. When a team scores an achievement a notice will be posted to the #capture-the-flag slack channel. 