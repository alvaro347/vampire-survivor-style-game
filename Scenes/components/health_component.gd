extends Node
class_name HealthComponent

signal died

 
@onready var max_health: float = owner.health
@export var current_health: float


func _ready() -> void:
	current_health = max_health


func take_damage(damage_taken: float) -> void:
	current_health = max(current_health - damage_taken,0)
	# NOTE: it checks the function in the next idle frame (to not get errors)
	Callable(check_death).call_deferred()


func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()