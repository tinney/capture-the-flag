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
window.sprites = [];

function setup(sprites) {
  var target = document.getElementsByClassName("canvas-target");
  target[0].appendChild(app.view);
  app.stage.addChild(sprite_container);

  sprites.forEach(addSprite)
}

function moveSprite(id, x, y) {
  window.sprites[id].position.set(x * BOARD_MULTIPLIER, y * BOARD_MULTIPLIER)
}

function addSprite(sprite) {
  // if (resource.is_food == true) {
  //   sprite_text = '🌴';
  // }
  let new_sprite = new PIXI.Text(sprite.icon, TEXT_SETTING) // TODO: This needs to come from the sprite
  new_sprite.x = sprite.x * BOARD_MULTIPLIER
  new_sprite.y = sprite.y * BOARD_MULTIPLIER

  sprite_container.addChild(new_sprite);
  window.sprites[sprite.id] = new_sprite
}

function removeSprite(id) {
  let sprite = window.sprites[id]
  window.sprites[id] = null;
  sprite_container.removeChild(sprite);
}
window.addSprite = addSprite
window.removeSprite = removeSprite
window.moveSprite = moveSprite

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