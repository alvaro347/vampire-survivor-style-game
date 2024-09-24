extends Node


# NOTE: Manage the data of the upgrades, listing it in a dicitonary.


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene
var current_upgrades: Dictionary = {}


func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade: bool = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	if upgrade.max_quantity > 0:
		var current_quantity: int = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func (pool_upgrade: AbilityUpgrade): return pool_upgrade.id != upgrade.id)
	
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func pick_upgrades() -> Array:
	var chosen_upgrade: AbilityUpgrade
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filtered_upgrades: Array[AbilityUpgrade] = upgrade_pool.duplicate()
	for i in 2:
		if filtered_upgrades.size() == 0:
			break
		chosen_upgrade = filtered_upgrades.pick_random()
		chosen_upgrades.append(chosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(func(upgrade: AbilityUpgrade): return upgrade.id != chosen_upgrade.id)
	return chosen_upgrades


func on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)


func on_level_up(current_level: int) -> void:
	var upgrade_screen_instance: CanvasLayer = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades: Array = pick_upgrades() # WARNING: Check type
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
