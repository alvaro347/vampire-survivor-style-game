extends CharacterBody2D


# const MAX_SPEED = 40
var direction : Vector2		# Direction of the enemy
@export var health : float = Globals.enemies.basic_enemy.health
@onready var player : Node2D = get_tree().get_first_node_in_group("player")
@onready var visuals = $Visuals
@onready var velocity_component: Node = $VelocityComponent
# @export var damage: float = Globals.enemies.basic_enemy.damage
# @onready var player : Node2D = get_node("/root/Main/Player")
# @onready var player : Node2D = %Player
# var player = preload("res://Scenes/player.tscn")


func _ready() -> void:
	$HurtBoxComponent.hit.connect(on_hit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass


# NOTE: Use physics process since it's meant for movement
func _physics_process(delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	# if player == null:
	# 	print("Player null")
	# 	return

	# direction = global_position.direction_to(player.global_position)	# It seems that this vector is normalized
	# velocity = direction * MAX_SPEED
	# move_and_slide()

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


# NOTE: Alternative verison to ge player's position and move towards player
# func get_direction_to_player() -> Vector2:
# 	var player_node : Node2D = get_tree().get_first_node_in_group("player") 
# 	if player_node != null:
# 		return (player_node.global_position - global_position).normalized()
# 	return Vector2.ZERO


# func on_area_entered(ohter_area: Area2D):
# 	health_component.take_damage(100)


func on_hit():
	$HitRandomAudioPlayerComponent.play_random()