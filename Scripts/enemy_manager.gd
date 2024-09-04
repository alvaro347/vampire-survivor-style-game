extends Node

# NOTE: Create a reference that corresponds to the packadScene selected
@export var basic_enemy_scene : PackedScene


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = %Player
	if player == null:
		return
