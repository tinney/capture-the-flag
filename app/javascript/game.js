import * as PIXI from 'pixi.js'
import { SSL_OP_EPHEMERAL_RSA } from 'constants';


const loader = new PIXI.Loader()
const players_container = new PIXI.Container()
const resource_container = new PIXI.Container()
const BOARD_WIDTH = 40
const BOARD_HEIGHT = 30
const BOARD_MULTIPLIER = 20
const TEXT_SETTING = {fontSize: 20, align: 'center', fontFamily: 'Courier', dropShadow: true,  dropShadowBlur: '4', dropShadowAlpha: '0.75', dropShadowDistance: '5'}

// note game heights are duplicated
const app = new PIXI.Application({ width: BOARD_MULTIPLIER * BOARD_WIDTH, height: BOARD_HEIGHT * BOARD_MULTIPLIER, transparent: true, antialias: true, resolution: 1, });

window.app = app;
// TODO update to be a single sprite container
window.players = [];
window.resources = [];

function setup(players, resources) {
  var target = document.getElementsByClassName("canvas-target");
  target[0].appendChild(app.view);
  app.stage.addChild(resource_container);
  app.stage.addChild(players_container);
  addPlayers(players)
  addResources(resources)
}

function addPlayers(players) {
  players.forEach(addPlayer)
}

function movePlayer(id, x, y) {
  window.players[id].position.set(x * BOARD_MULTIPLIER, y * BOARD_MULTIPLIER)
}

function addPlayer(player) {
  let sprite = new PIXI.Text('💚', TEXT_SETTING)
  sprite.x = player.x * BOARD_MULTIPLIER
  sprite.y = player.y * BOARD_MULTIPLIER

  players_container.addChild(sprite);
  window.players[player.id] = sprite
}

function addResources(resources) {
  resources.forEach(addResource)
}

function removeResource(id) {
  let resource = window.resources[id];
  window.resources[id] = null;
  resource_container.removeChild(resource);
}

function removePlayer(id) {
  let resource = window.players[id]
  window.players[id] = null;
  players_container.removeChild(resource);
}

function addResource(resource) {
  let sprite_text = '💧';
  if (resource.is_food == true) {
    sprite_text = '🌴';
  }
  
  let sprite = new PIXI.Text(sprite_text, TEXT_SETTING)
  sprite.x = resource.x * BOARD_MULTIPLIER
  sprite.y = resource.y * BOARD_MULTIPLIER

  resource_container.addChild(sprite);
  window.resources[resource.id] = sprite
}

window.addPlayer = addPlayer
window.removePlayer = removePlayer
window.removeResource = removeResource
window.movePlayer = movePlayer
window.addResource = addResource

window.startGame = function(players, resources) {
  const f = function() {
    setup(players, resources);
  }
  loader.load(f);
}

window.startMoves = function(moves) {
  console.log(moves)

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