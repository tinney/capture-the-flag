import consumer from "./consumer"

consumer.subscriptions.create({ channel: "PlayersChannel" }, {
  received(data) {
    if (data.action === 'created') {
      if (data.is_player === true) {
        window.addPlayer(data)
      } else {
        window.addResource(data)
      }
    } 

    if (data.action === "destroyed") {
      if (data.is_player) {
        window.removePlayer(data.id)
      } else {
        window.removeResource(data.id)
      }
    }

    window.app.ticker.addOnce((delta) => {
      if (data.action === "moved") {
          window.movePlayer(data.id, data.x, data.y) 
      }
    });
  },
})