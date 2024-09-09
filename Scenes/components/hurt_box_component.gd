extends Area2D

class_name HurtBoxComponent

@export var health_component: Node



func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitBoxComponent:
		return
	if health_component == null:
		return

	var hitbox_component: HitBoxComponent = other_area
	health_component.damage(hitbox_component.damage)