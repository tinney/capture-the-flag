import consumer from "./consumer"

consumer.subscriptions.create({ channel: "BoardChannel" }, {
  received(data) {
    window.redrawBoard(data.players)
  }
})