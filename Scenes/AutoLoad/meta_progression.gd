extends Node


var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}


func _ready():
	GameEvents.expirience_vial_collected.connect(on_exprience_collected)
	add_meta_upgrade(load("res://resources/meta_upgrades/exprience_gain.tres"))


func add_meta_upgrade(upgrade: MetaUpgrade):
	if !save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}

	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	print(save_data)


func on_exprience_collected(number: float):
	save_data["meta_upgrade_currency"] += number
