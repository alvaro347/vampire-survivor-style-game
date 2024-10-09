extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.player_damage.connect(on_player_damage)


func on_player_damage():
	$AnimationPlayer.play("hit")
