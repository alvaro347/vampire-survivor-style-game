extends Node
class_name HealthComponent


signal died
signal health_changed

 
@onready var max_health: float = owner.health
@export var current_health: float


func _ready() -> void:
	current_health = max_health
	

func take_damage(damage_taken: float) -> void:
	current_health = max(current_health - damage_taken, 0)
	health_changed.emit()
	# NOTE: it checks the function in the next idle frame (to not get errors)
	Callable(check_death).call_deferred()


# Check if health is 0 and return number that it's not greater than 1
func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)


func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()