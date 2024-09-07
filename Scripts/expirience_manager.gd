extends Node

var current_expirience = 0


func _ready() -> void:
	GameEvents.expirience_vial_collected.connect(on_exprience_vial_collected)


func increment_expirience(number: float) -> void:
	current_expirience += number
	print(current_expirience)

func on_exprience_vial_collected(number: float) -> void:
	increment_expirience(number)