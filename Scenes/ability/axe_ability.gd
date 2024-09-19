extends Node2D


@onready var hitbox_component: HitBoxComponent = $HitBoxComponent
const MAX_RADIUS: float = 100.0

var base_rotation: Vector2 = Vector2.RIGHT


func _ready() -> void:
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var tween = create_tween() # NOTE: For animations
	tween.tween_method(tween_method, 0.0, 2.0, 3) # Interpolate between 0 and 2 every 2 secs
	tween.tween_callback(queue_free) # Only need to pass a reference for that method


func tween_method(rotations: float) -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	var percent: float = rotations / 2.0
	var current_radius: float = percent * MAX_RADIUS
	var current_direction: Vector2 = base_rotation.rotated(rotations * TAU)
	
	global_position = player.global_position + (current_direction * current_radius)