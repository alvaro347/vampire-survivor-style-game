extends Node

@export var axe_ability: PackedScene
var base_damage  = 10
var additional_damage_percent = 1


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player")
	var foreground: Node2D = get_tree().get_first_node_in_group("foreground_layer")
	if player == null || foreground == null:
		return
	
	var axe_instance: Node2D = axe_ability.instantiate()
	axe_instance.global_position = player.global_position
	foreground.add_child(axe_instance)
	axe_instance.hitbox_component.damage = base_damage * additional_damage_percent


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id == "axe_damage":
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["quantity"] * 0.1)