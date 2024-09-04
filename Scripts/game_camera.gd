extends Camera2D

var target_position : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# make_current()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# NOTE: A way of making the camear follow the player
	# NOTE: if the function was separate we could use global_position.lerp(target_position, 1.0 - expo(- delta * 10))
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))


func acquire_target() -> void:
	var player : Node2D = %Player
	if player == null:
		return
	target_position = player.global_position