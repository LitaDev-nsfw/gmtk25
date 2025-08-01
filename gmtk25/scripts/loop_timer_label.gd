extends Label

func _ready() -> void:
	text = str(int(get_parent().time_left))
