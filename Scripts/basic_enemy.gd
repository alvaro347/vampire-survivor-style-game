extends CharacterBody2D


const MAX_SPEED = 40
var direction : Vector2		# Direction of the enemy
# @onready var player : Node2D = get_node("/root/Main/Player")
@onready var player : Node2D = get_tree().get_first_node_in_group("player")
@export var basic_enemy_damage : float = Globals.enemy_damage.basic_enemy
# @onready var player : Node2D = %Player
# var player = preload("res://Scenes/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass


# NOTE: Use physics process since it's meant for movement
func _physics_process(delta: float) -> void:
	if player == null:
		print("Player null")
		return
	direction = global_position.direction_to(player.global_position)	# It seems that this vector is normalized
	velocity = direction * MAX_SPEED
	move_and_slide()


# NOTE: Alternative verison to ge player's position and move towards player
# func get_direction_to_player() -> Vector2:
# 	var player_node : Node2D = get_tree().get_first_node_in_group("player") 
# 	if player_node != null:
# 		return (player_node.global_position - global_position).normalized()
# 	return Vector2.ZERO


func on_area_entered(ohter_area: Area2D):
	player.take_damage(basic_enemy_damage)
	print(basic_enemy_damage)
	queue_free()

