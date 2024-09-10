extends CanvasLayer


# NOTE: Progress Bar value updates.


@export var expirience_manager: Node
@onready var progress_bar : ProgressBar = $MarginContainer/ProgressBar


func _ready() -> void:
	progress_bar.value = 0.0
	expirience_manager.expirience_updated.connect(on_expirience_updated)


func on_expirience_updated(current_expirience: float, target_expirience: float) -> void:
	var percent = current_expirience / target_expirience
	progress_bar.value = percent