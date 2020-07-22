import consumer from "./consumer"

consumer.subscriptions.create({ channel: "BoardChannel" }, {
  received(data) {
    window.updateScores(data.teams)
    window.redrawBoard(data.players)
  }
})