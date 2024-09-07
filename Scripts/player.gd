extends CharacterBody2D
class_name Player
	

const MAX_SPEED : float = 150
const ACCELERATION_SMOOTHING : float = 25
var current_health : float

func _ready() -> void:
	current_health = Globals.max_health


func _process(delta: float) -> void:
	var movement_vector : Vector2 = get_movement_vector()
	# We need to normalize the vector not get a speed larger than 1
	var direction = movement_vector.normalized()	
	var target_velocity = direction * MAX_SPEED
	# NOTE: LERP is linear interpolation
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector() -> Vector2:
	# NOTE: This is to setup the x y movement
	# Get x and y movement with positve and nevgative values for each axys
	# var movement_vector : Vector2 = Vector2.ZERO	// Creates a vector with x and y compoennt
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")	# Creates a number from -1 to 1 for x axys
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	# Creates a -1 to 1 for y axys
	return Vector2(x_movement, y_movement)


func take_damage(damage: float) -> void:
	current_health = max(current_health - damage, 0)	# NOTE: Avoids negative values and sets to 0
	print(current_health)
	if current_health == 0:
		died()


func died() -> void:
	queue_free()
