extends Node


signal expirience_vial_collected(number: float)


func emit_experience_vial_collect(number: float) -> void:
	expirience_vial_collected.emit(number)

