extends PanelContainer


signal selected


@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel

var disable = false


func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)


func play_in(delay: float) -> void:
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")


func set_ability_upgrade(upgrade: AbilityUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func play_discard() -> void:
	$AnimationPlayer.play("discard")


func select_card() -> void:
	disable = true
	$AnimationPlayer.play("selected")

	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()

	await $AnimationPlayer.animation_finished
	selected.emit()


func on_gui_input(event: InputEvent) -> void:
	if disable:
		return
	if event.is_action_pressed("left_click"):
		select_card()

func on_mouse_entered() -> void:
	if disable:
		return
	$AnimationPlayerHover.play("hover")