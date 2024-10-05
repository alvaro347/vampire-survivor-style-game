extends Node


const MAX_RANGE: int = 150
var base_wait_time: float
var base_damage : float = 5.0
var additional_damage_percent = 1
@export var sword_ability : PackedScene
@onready var player : Node2D = get_tree().get_first_node_in_group("player")
# NOTE: This is the same as exporting this variable as a PackedScene and adding the reference in the inspector. We don't need @onready for this case since it's implied in preload.
# @export var sword_ability = preload("res://Scenes/ability/sword_ability.tscn")


func _ready() -> void:
	# NOTE: This is creating a signal "timeout" that connects to the function spawn_sword
	base_wait_time = $SwordTimer.wait_time
	$SwordTimer.timeout.connect(spawn_sword)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

# NOTE: Signals can connect to other functions we specify
func spawn_sword() -> void:
	if player == null:
		return
	# NOTE: we can get the enemies array from the group
	# NOTE: This allows to filter the elements in the array where their position to player is less than the MAX_RANGE
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func (enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	# NOTE: To be safe and not cause errors but player should always be there
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b:Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	var sword_instance : SwordAbility = sword_ability.instantiate()
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = base_damage * additional_damage_percent
	# NOTE: To add a random radious away. Tau is 2x pi. Randomize the rotaion of this vector from 0 to 360 by offset of 4
	sword_instance.global_position = enemies[0].global_position + Vector2.RIGHT.rotated(randf_range(0,TAU)) * 4
	# NOTE: We can angle towards the enemy this way. (To -> FROM for calculations). Then set the rotation to that value
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


# NOTE: Chanage the ability upgrade rate, in this case the sword
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id == "sword_rate":
		var percent_reduciton = current_upgrades["sword_rate"]["quantity"] * 0.5
		$SwordTimer.wait_time = base_wait_time * (1 - percent_reduciton)
		$SwordTimer.start()
	elif upgrade.id == "sword_damage":
		additional_damage_percent = 1 + (current_upgrades["sword_damage"]["quantity"] * 0.15)
	
