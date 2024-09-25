extends CharacterBody2D
class_name Player
	

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals

const MAX_SPEED: float = 150
const ACCELERATION_SMOOTHING: float = 25

var health: float = 10.0
var number_colliding_bodies: int = 0
# var current_health: float


func _ready() -> void:
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	# current_health = Globals.max_health
	damage_interval_timer.timeout.connect(on_damage_inerval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	on_health_changed()


func _process(delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	# We need to normalize the vector not get a speed larger than 1
	var direction: Vector2 = movement_vector.normalized()
	var target_velocity: Vector2 = direction * MAX_SPEED
	# NOTE: LERP is linear interpolation
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()
	if movement_vector.x != 0 || movement_vector.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
	var move_sign = sign(movement_vector.x)
	if move_sign == 0:
		visuals.scale = Vector2.ONE
	else:
		visuals.scale = Vector2(move_sign, 1)


func get_movement_vector() -> Vector2:
	# NOTE: This is to setup the x y movement
	# Get x and y movement with positve and nevgative values for each axys
	# var movement_vector : Vector2 = Vector2.ZERO	// Creates a vector with x and y compoennt
	var x_movement: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") # Creates a number from -1 to 1 for x axys
	var y_movement: float = Input.get_action_strength("move_down") - Input.get_action_strength("move_up") # Creates a -1 to 1 for y axys
	return Vector2(x_movement, y_movement)


func check_deal_damage() -> void:
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	else:
		health_component.take_damage(1)
		damage_interval_timer.start()
	print(health_component.current_health)
	

# Supossed to be called to update the health bar component
func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()


func on_body_entered(other_body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D) -> void:
	number_colliding_bodies -= 1


func on_damage_inerval_timer_timeout() -> void:
	check_deal_damage()


func on_health_changed() -> void:
	update_health_display()


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if not ability_upgrade is Ability:
		return
	var ability: Ability = ability_upgrade
	abilities.add_child(ability.ability_controller_scene.instantiate())
