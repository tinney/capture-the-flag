# 💚 2020 Test Double Capture the Flag

Welcome to the Test Double 2020 Virtual Retreat -- Capture the flag
The object of the challenge is to take the other teams flag from their side to your side. 

## Object of the game

The object of the game is to earn the most points as a team before the end of the retreat. There will be an offical timer posted in the #capture-the-flag retreat channel so Ilana & Kevin can't cheat this time. 

## Starting the Game

* Players will start randomly within their base location. 

* Players will start with a peg (more info later)

* Team flag is randomly hidden at the end of each teams base 0 - 5 for the left side base & 75 - 80 for the right side base.

  

## The Field

The Field is a 80x40 grid. The first 5 and last 5 spaces of each zone is designated for the flag. 

``Flag Zone          Left Field                        Right Field         Flag Zone`
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 
`. . . . . | . . . . . . . . . . . . . . . | . . . . . . . . . . . . . . | . . . . .` 

## The Flag

1 flag is randomly placed in each teams flag zone.  Once a flag has been picked up the opposing team will always be able to know it's location until it has been captured.  

## Moving

Moving is sent by sending post requests to the move endpoint. Move directions are based on NORTH, SOUTH, EAST, and WEST. Note the websockets used to show the live board can disconnect, if this happens you'll need to refresh your browser to see the player move.



## Scoring Points

There are many ways to score points for your team. 

* Picking up the flag is worth 5 points

* Capturing another teams flag, moving onto the flag position and then moving to your base is worth 25 points. 

* Capturing another players peg is worth 15 points 

* Replacing your own flag is worth 10 points

* Achievements (see achievements)

  

  ### Capturing the Flag

  To pick up the flag you must leave your base, cross your opponents base to the "flag zone" and find the flag and move onto it's space. Once you have picked up the flag you must travel back across your opponents base past the half way point of the field for a capture.  

  

  Captures are worth 25 points & flag pickups are worth 5 points.  

  

  Once a flag is captured a new flag will replace it.

  

  ### Capturing a Peg

  To capture an opponents peg you must move to the same space they are on. Peg captures are worth 15 points. 

  

  ### The Flag Zone

  At the end of each teams base is a 5x40 zone for the flag.  The team cannot enter their own flag zone. This is so you cannot just stand on your own flag to guard it. Once an opponent enters your flag zone they will be safe to find the flag but must recross your base for the capture. 

  

  ### Achievements

  There are a random number of achievements each team can be awarded during the game.  Achievement points are based on the difficulty of the achievement and range from 1 point to 100 points. When a team scores an achievement a notice will be posted to the #capture-the-flag slack channel. 