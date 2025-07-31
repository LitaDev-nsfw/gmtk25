extends Label

var delta_sum : float = 0

func _ready() -> void:
	text = str(int(get_parent().time_left))

func _process(delta: float) -> void:
	delta_sum += delta
	if delta_sum >= 0.5:
		delta_sum = 0
		text = str(int(get_parent().time_left))
