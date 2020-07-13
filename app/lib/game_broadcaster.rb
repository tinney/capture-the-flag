class GameBroadcaster
  def self.broadcast_sprite_created(player)
    ActionCable.server.broadcast(
      "sprites",
      action: 'created',
      is_player: true, 
      is_flag: false, 
      id: player.id, 
      x: player.x, 
      y: player.y,
    )
  end
  def self.broadcast_resource_destroyed(resource)
    ActionCable.server.broadcast(
      "sprites",
      action: 'destroyed',
      id: resource.id, 
      is_player: false, 
      is_flag: true
    )
  end
  
  def self.broadcast_sprite_moved(sprite)
    ActionCable.server.broadcast(
      "sprites",
      action: 'moved',
      id: sprite.id, 
      x: sprite.x, 
      y: sprite.y,
    )
  end
end
