extends CanvasLayer

@onready var panel_container = $%PanelContainer


func _ready() -> void:
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	get_tree().paused = true
	%ContinueButton.pressed.connect(on_continue_button_pressed)
	%QuitButton.pressed.connect(on_quit_button_pressed)


func set_defeat() -> void:
	%TitleLabel.text = "Defeated"
	%DescriptionLabel.text = "You Lost!"
	play_jingle(true)


func play_jingle(defeat: bool = false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()


# Remove current main and reload main again
func on_continue_button_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

# Quit the main file and close our game
func on_quit_button_pressed() -> void:
	ScreenTransition.transition()
	ScreenTransition.transition_to_scene("res://Scenes/ui/main_menu.gd")
	await ScreenTransition.transition_halfway
	get_tree().paused = false