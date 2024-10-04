extends Area2D

class_name HurtBoxComponent

@export var health_component: Node

var floating_text_scene = preload("res://Scenes/ui/floating_text.tscn")


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitBoxComponent:
		return
	if health_component == null:
		return

	var hitbox_component: HitBoxComponent = other_area
	health_component.take_damage(hitbox_component.damage)
	
	var floating_text: Node2D = floating_text_scene.instantiate()
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)

	floating_text.global_position = global_position + (Vector2.UP * 16)
	floating_text.start(str(hitbox_component.damage))