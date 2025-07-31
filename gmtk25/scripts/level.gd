extends Node2D
class_name Level

signal change_level
signal add_time_to_loop
@onready var label : Label = $Label

func _ready() -> void:
	if label:
		label.text = name
		label.position = Vector2(920.0, 123)
		
func _on_change_level() -> void:
	change_level.emit()
	add_time(5)

func add_time(added_time : int) -> void:
	add_time_to_loop.emit(added_time)
