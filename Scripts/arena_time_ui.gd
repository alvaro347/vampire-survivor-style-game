extends CanvasLayer

# @export var arena_time_manager: Node
@onready var timer : Timer = $Timer
@onready var label : Label = $MarginContainer/Label


func _process(delta: float) -> void:
	var time_elapsed : float = get_time_elapse()
	# NOTE: This is one way. Giving the decimal and the rounding point
	# label.text = str(snapped(time_elapsed, 0.1))
	# NOTE: We format it in clock "0:00" format
	label.text = format_seconds_to_string(time_elapsed)


func get_time_elapse() -> float:
	return timer.wait_time - timer.time_left


func format_seconds_to_string(seconds: float):
	var minutes : float = floor(seconds / 60)
	var remaining_seconds : float = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))