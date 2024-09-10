extends Node


# NOTE: We will manage the expriences here. 


signal expirience_updated(current_expirience: float, target_expirience: float)
signal level_up(new_level: int)


const TARGET_EXPIRIENCE_GROWTH : float = 5.0
var current_expirience : float = 0
var current_level : float = 1.0
var target_expirience : float = 5.0


func _ready() -> void:
	GameEvents.expirience_vial_collected.connect(on_exprience_vial_collected)


func increment_expirience(number: float) -> void:
	current_expirience = min(current_expirience + number, target_expirience)
	expirience_updated.emit(current_expirience, target_expirience)
	if current_expirience == target_expirience:
		current_level += 1.0
		target_expirience += TARGET_EXPIRIENCE_GROWTH
		current_expirience = 0.0
		expirience_updated.emit(current_expirience, target_expirience)
		level_up.emit(current_level)

func on_exprience_vial_collected(number: float) -> void:
	increment_expirience(number)