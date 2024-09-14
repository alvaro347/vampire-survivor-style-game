extends CanvasLayer


func _ready() -> void:
	get_tree().paused = true
	%RestartButton.pressed.connect(on_restart_button_pressed)
	%QuitButton.pressed.connect(on_quit_button_pressed)


func set_defeat() -> void:
	%TitleLabel.text = "Defeated"
	%DescriptionLabel.text = "You Lost!"


# Remove current main and reload main again
func on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

# Quit the main file and close our game
func on_quit_button_pressed() -> void:
	get_tree().quit()