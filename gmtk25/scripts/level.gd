extends Node2D
class_name Level

signal change_level
@onready var label : Label = $Label

func _ready() -> void:
	if label:
		label.text = name
		label.position = Vector2(920.0, 123)
		
func _on_change_level() -> void:
	change_level.emit()
