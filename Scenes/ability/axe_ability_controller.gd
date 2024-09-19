extends Node

@export var axe_ability: PackedScene
var damage  = 10


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player")
	var foreground: Node2D = get_tree().get_first_node_in_group("foreground_layer")
	if player == null || foreground == null:
		return
	
	var axe_instance: Node2D = axe_ability.instantiate()
	axe_instance.global_position = player.global_position
	foreground.add_child(axe_instance)
	axe_instance.hitbox_component.damage = damage
