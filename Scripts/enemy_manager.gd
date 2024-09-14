extends Node

const SPAWN_RADIUS: int = 375 # Min 10px outside boundery of the window (since window is 640px)
# NOTE: Create a reference that corresponds to the packadScene selected
@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0


func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func on_timer_timeout():
	timer.start()
	# var player : Node2D = %Player
	var player: Node2D = get_tree().get_first_node_in_group("player")

	if player == null:
		print("Player not foudn")
		return
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU)) # From one point we rotate it randomnly
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)
	var enemy: Node2D = basic_enemy_scene.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	enemy.global_position = spawn_position
	entities_layer.add_child(enemy)


func on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off = min((0.1 / 12) * arena_difficulty, 0.7) # Could be replace with an exponential function, with min value
	print(time_off)
	timer.wait_time = base_spawn_time - time_off # Timer stablished in Godot - calculation
