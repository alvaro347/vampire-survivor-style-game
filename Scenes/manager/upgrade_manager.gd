extends Node


# NOTE: Manage the data of the upgrades, listing it in a dicitonary.


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
var current_upgrades : Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func on_level_up(current_level: int) -> void:
	var chosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return

	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	if !has_upgrade:
		current_upgrades[chosen_upgrade.id] = {
			"resource": chosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[chosen_upgrade.id]["quantity"] += 1
		
	print (current_upgrades)