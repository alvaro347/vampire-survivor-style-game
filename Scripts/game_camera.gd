extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# NOTE: A way of making the camear follow the player
	# ~ if the function was separate we could use global_position.lerp(target_position, 1.0 - expo(- delta * 10))
	var player_nodes : Array = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player : Node2D = player_nodes[0]
		global_position = player.global_position