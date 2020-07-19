import * as PIXI from 'pixi.js'
import { SSL_OP_EPHEMERAL_RSA } from 'constants';


const loader = new PIXI.Loader()
const sprite_container = new PIXI.Container()
const BOARD_WIDTH = 80
const BOARD_HEIGHT = 40 
const BOARD_MULTIPLIER = 20

const FLAG_TEXT_SETTING = {fontSize: 20, align: 'center', fontFamily: 'Courier' }
const PLAYER_TEXT_SETTING = {fontSize: 20, align: 'center', fontFamily: 'Courier', dropShadow: true,  dropShadowColor: '#CA2603', dropShadowBlur: '2', dropShadowAlpha: '0.8', dropShadowDistance: '4'}
const PLAYER_TEXT_SETTING_WITH_PEG = {fontSize: 20, align: 'center', fontFamily: 'Courier', dropShadow: true,  dropShadowBlur: '1', dropShadowAlpha: '0.6', dropShadowDistance: '1'}

// note game heights are duplicated
const app = new PIXI.Application({ width: BOARD_MULTIPLIER * BOARD_WIDTH, height: BOARD_HEIGHT * BOARD_MULTIPLIER, transparent: true, antialias: true, resolution: 1, });
window.app = app;

window.redrawBoard = function(players) {
  sprite_container.removeChildren();
  players.forEach(addPlayerSprite)
}

function setup(players) {
  var target = document.getElementsByClassName("canvas-target");
  target[0].appendChild(app.view);
  app.stage.addChild(sprite_container);

  window.redrawBoard(players)
}

function getTextSettingsForPlayer(playerData) {
  return playerData.has_peg ? PLAYER_TEXT_SETTING_WITH_PEG : PLAYER_TEXT_SETTING;
}

function addFlag(x, y) {
  let flag = new PIXI.Text('🚩', FLAG_TEXT_SETTING);
  flag.x= x * BOARD_MULTIPLIER
  flag.y= y * BOARD_MULTIPLIER
  sprite_container.addChild(flag);
}

window.addPlayerSprite = function(playerData) {
  let sprite = new PIXI.Text(playerData.icon, getTextSettingsForPlayer(playerData));
  const x = playerData.x * BOARD_MULTIPLIER
  const y = playerData.y * BOARD_MULTIPLIER
  sprite.x = x;
  sprite.y = y;

  sprite_container.addChild(sprite);
  if(playerData.has_flag) { addFlag(x, y) }

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