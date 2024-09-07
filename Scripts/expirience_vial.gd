extends Node2D


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)


func on_area_entered(ohter_area: Area2D) -> void:
	GameEvents.emit_experience_vial_collect(1)
	queue_free()

