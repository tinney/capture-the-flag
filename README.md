# 💚 2020 Test Double Capture the Flag



## ¡¡¡¡WARNING!!!!

This "game" is a hobby project (as you'll be able to tell quickly from all the grammer errors in this doc). You all are very very smart peope and WILL be able to hack it if you try. Even if I wanted to stop you I'm very certain I wouldn't be smart enough to figure how to! 

Most endpoints, responses, models etc are left open to make it easy for us to live debug today, for saving time on development and overall because we can w/ our trust in y'all. Please please please be nice so our tiny heroku hobby servers can handle today. 

Thanks, and enjoy! 



## Object of the game

The object of the game is to earn the most points as a team before the end of the retreat day. Points are earned by capturing a the opponents flag or catching an opponent when they are on your side. Your team will likely want to decide who is writing the bots to guard their flag vs bots to capture the opponents flag.

There will be an offical timer posted in the #capture-the-flag retreat channel so Ilana & Kevin can't cheat this time . 



## Gems / Package

Based on feedback from the last retreat we are providing a ruby gem and a javascript package you can use to avoid having to worry httparty, headers and whatever else you all graciously put up with last retreat. 

The Gem/Package can be found here.  Big thanks to Mr. Dan spending his time to create them as well as being one of the best rubber ducks around. 

* Ruby: https://github.com/danthompson/capture-the-flag-client-rb

* JavaScript: https://github.com/danthompson/capture-the-flag-client-js

* Go:  (╯°□°）╯︵ ┻━┻ 

  

## The Field

The Field is a 80x40 grid. The first 5 and last 5 spaces of the field are designated flag zones for each team and can only be entered by the opponents. 

```
Flag Zone          Left Field                 Right Field         Flag Zone
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . . 
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . .
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . .
. . . . . | . . . . . . . . . . . . . | . . . . . . . . . . . . | . . . . .
```



## Your Player

* Your player will start randomly within their base location. 
* Players will start with a peg (more info later)
* Your team flag is randomly hidden at the end of each teams base 0 - 5 for the left side base & 75 - 80 for the right side base.
* /player will allow you to programatically see where your player has landed 



## The Flag

1 flag at a time is randomly placed in each teams flag zone.  Once a flag has been picked up the opposing team the it's location will be known by the opponents team until the flag has been captured.



## Moving

Moving is sent by sending post requests to the move endpoint. Move directions are based on NORTH, SOUTH, EAST, and WEST.  More information on moving can be found in the gem documentation which will be posted when the game begins. 



## Seeing

Players can see in 5 squares around them.  If a player has the sight ability they will be able to see 10 squares around them. Opponents near you will be returned when making a move or by doing a get on your player's endpoint 



## Scoring Points

There are 4 ways to score points for your team. 

* Picking up the flag is worth 5 points

* Capturing another teams flag is worth 25 points. 

* Capturing another players peg is worth 15 points 

* Replacing your own flag from an opponent carrier is worth 30 points

  

  

  ### Capturing the Flag

  To pick up the flag you must leave your base, cross your opponents base to the "flag zone" and find the flag and move onto it's space. Once you have picked up the flag you must travel back across your opponents base past the half way point of the field (x = 40) for a capture.  

  

  You must have a peg in order to pick up the flag. When you have the flag if you enter an opponent's square then they will steal it and your peg from you. Players who have agility on have a 30% chance of avoiding the opponent's recapture and moving past. 

  

  Captures are worth 25 points & flag pickups are worth 5 points.  Once a flag is captured a new flag will replace it.

  

  ### Capturing a Peg

  To capture an opponents peg you must move to the same space they are on. Peg captures are worth 15 points. A player w/out a peg will glow red on the map. Players who have agility on have a 30% chance of avoiding a peg capture. 

  

  If you are in your opponents base and you move onto an opponents space they will have a chance to take your peg and flag. 

  
  
  ### The Flag Zone
  
  At the end of each teams base is a 5x40 zone for the flag.  The team cannot enter their own flag zone. This is so you cannot just stand on your own flag to guard it. Once an opponent enters your flag zone they will be safe to find the flag but must recross your base for the capture. 



