extends PanelContainer


@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel
@onready var progress_bar = $%ProgressBar
@onready var purchase_button = $%PurchaseButton
@onready var progress_label = $%ProgressLabel

var upgrade: MetaUpgrade


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)


func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()
	


func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = MetaProgression.save_data["meta_upgrade_currency"] / upgrade.exprience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.exprience_cost)


func select_card() -> void:
	$AnimationPlayer.play("selected")


func on_purchase_pressed():
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.exprience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("selected")
