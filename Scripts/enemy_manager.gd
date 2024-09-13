extends Node

const SPAWN_RADIUS : int = 375	# Min 10px outside boundery of the window (since window is 640px)
# NOTE: Create a reference that corresponds to the packadScene selected
@export var basic_enemy_scene : PackedScene


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	# var player : Node2D = %Player
	var player : Node2D = get_tree().get_first_node_in_group("player")

	if player == null:
		print("Player not foudn")
		return
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))	# From one point we rotate it randomnly
	var spawn_position : Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)
	var enemy : Node2D = basic_enemy_scene.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	enemy.global_position = spawn_position
	entities_layer.add_child(enemy)
	
