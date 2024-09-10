extends Node


# NOTE: Manage the data of the upgrades, listing it in a dicitonary.


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene
var current_upgrades : Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func on_level_up(current_level: int) -> void:
	var chosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])


func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1