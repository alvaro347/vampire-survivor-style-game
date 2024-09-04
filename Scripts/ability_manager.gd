extends Node

const MAX_RANGE = 150
@onready var player : Node2D = self.get_parent()
# NOTE: This is the same as exporting this variable as a PackedScene and adding the reference in the inspector. We don't need @onready for this case since it's implied in preload.
@export var sword_ability = preload("res://Scenes/ability/sword_ability.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# NOTE: This is creating a signal "timeout" that connects to the function spawn_sword
	$SwordTimer.timeout.connect(spawn_sword)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
	# add_child(sword_ability.sword_instance)
	# spawn_sword()
	# pass


# NOTE: Signals can connect to other functions we specify
func spawn_sword() -> void:
	if player == null:
		return

	# NOTE: we can get the enemies array from the group
	# NOTE: This allows to filter the elements in the array where their position to player is less than the MAX_RANGE
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func (enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)

	# NOTE: To be safe and not cause errors but player should always be there
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b:Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	var sword_instance : Node2D = sword_ability.instantiate()
	player.get_parent().add_child(sword_instance)
	# NOTE: To add a random radious away. Tau is 2x pi. Randomize the rotaion of this vector from 0 to 360 by offset of 4
	sword_instance.global_position = enemies[0].global_position + Vector2.RIGHT.rotated(randf_range(0,TAU)) * 4
	# NOTE: We can angle towards the enemy this way. (To -> FROM for calculations). Then set the rotation to that value
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
	

	
