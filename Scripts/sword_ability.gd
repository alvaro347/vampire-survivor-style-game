extends Node2D

# const SWORD = preload("res://Scenes/ability/sword_ability.tscn")
@export var sword_ability : PackedScene
# @onready var sword_ability : Node2D = $"."
# @onready var player : Node2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# ~ In the tutorial the scrip is in another scene (with the timer) then it has to select and open the timer node with get_note("Timer)
	# get_node("Timer").timeout
	# $Timer.timeout to replace get_node()
	# ` Instead of using godot's signals we can connect it manually like this
	# $Timer.timeout.connect(ability_instance)
	pass



func ability_instance() -> void:
	pass
	# new_sword.global_position = %Player.global_position
	# %Player.add_child(new_sword)
	# var sword_instance : Node2D = sword_ability.instantiate()
	# global_position = player.global_position
	# player.add_child(sword_instance)
	# add_child(sword_instance)
	# add_child(sword_instance)


# func _on_timer_timeout() -> void:
# 	print("Instance Happening")
# 	var new_sword : Node2D = SWORD.instantiate()
# 	new_sword.global_position = Vector2(0,1)
# 	player.add_child(new_sword)
	# var instance = ability_instance()
	# player.spawn_sword
