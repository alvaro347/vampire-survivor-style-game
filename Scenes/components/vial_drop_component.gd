extends Node

# NOTE: We can add range to our values
@export_range(0,1) var drop_percent: float = 0.5
@export var vial_scene: PackedScene
@export var health_component: Node


func _ready() -> void:
	(health_component as HealthComponent).died.connect(on_died)


func on_died() -> void:
	var adjusted_drop_percent = drop_percent
	var expirience_grain_upgrade_count = MetaProgression.get_upgrade_count("exprience_gain")
	if expirience_grain_upgrade_count > 0:
		adjusted_drop_percent += 0.1
	if randf() >= adjusted_drop_percent:
		return
	if vial_scene == null:
		return
	if not owner is Node2D:
		return
	# NOTE: Reference the vial scene then instantiate it
	var spawn_position = (owner as Node2D).global_position
	var vial_instance : Node2D = vial_scene.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
