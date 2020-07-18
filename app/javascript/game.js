import * as PIXI from 'pixi.js'
import { SSL_OP_EPHEMERAL_RSA } from 'constants';


const loader = new PIXI.Loader()
const sprite_container = new PIXI.Container()
const BOARD_WIDTH = 80
const BOARD_HEIGHT = 40 
const BOARD_MULTIPLIER = 20
const TEXT_SETTING = {fontSize: 20, align: 'center', fontFamily: 'Courier', dropShadow: true,  dropShadowBlur: '4', dropShadowAlpha: '0.75', dropShadowDistance: '5'}

// note game heights are duplicated
const app = new PIXI.Application({ width: BOARD_MULTIPLIER * BOARD_WIDTH, height: BOARD_HEIGHT * BOARD_MULTIPLIER, transparent: true, antialias: true, resolution: 1, });
window.app = app;

function setup(players) {
  var target = document.getElementsByClassName("canvas-target");
  target[0].appendChild(app.view);
  app.stage.addChild(sprite_container);

  players.forEach(addSprite)
}

window.redrawBoard = function(players) {
  sprite_container.removeChildren();
  players.forEach(addSprite)
}

window.addSprite = function(sprite) {
  let new_sprite = new PIXI.Text(sprite.icon, TEXT_SETTING)
  new_sprite.x = sprite.x * BOARD_MULTIPLIER
  new_sprite.y = sprite.y * BOARD_MULTIPLIER

  sprite_container.addChild(new_sprite);
}

window.startGame = function(sprites) {
  const f = function() {
    setup(sprites);
  }
  loader.load(f);
}

window.startMoves = function(moves) {
  let myGraph = new PIXI.Graphics();

  var target = document.getElementsByClassName("canvas-target");
  target[0].appendChild(app.view);
  app.stage.addChild(myGraph);

  // Move it to the beginning of the line
  var start_x = moves[0].x
  var start_y = moves[0].y
  myGraph.position.set(0, 0)
  myGraph.lineStyle(4, 0x75fe04).moveTo(start_x * BOARD_MULTIPLIER, start_y * BOARD_MULTIPLIER)
  moves.forEach(function(move){
    myGraph.lineTo(move.x * BOARD_MULTIPLIER, move.y * BOARD_MULTIPLIER);
  });
}