extends Node

@export var max_speed: int = 40
@export var acceleration: float = 5

var velocity:Vector2 = Vector2.ZERO


func accelerate_to_player() -> void:
	var owner_node2d: Node2D = owner
	if owner_node2d == null:
		return
	var player: Node2D = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var direction = (player.global_position - owner_node2d.global_position).normalized()
	accelerate_in_direction(direction)


func accelerate_in_direction(direction: Vector2) -> void:
	var desired_velocity = direction * max_speed
	# NOTE: Go from current velocity to desired velocity at a given percen (last part of the function)
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))
	

func decelerate():
	accelerate_in_direction(Vector2.ZERO)


func move(character_body: CharacterBody2D) -> void:
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity