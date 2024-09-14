extends Node


@export var end_screen_scene: PackedScene


func _ready() -> void:
	%Player.health_component.died.connect(on_player_died)


# In this case we set defeat after instantiating since it's not yet in the tree
func on_player_died() -> void:
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()