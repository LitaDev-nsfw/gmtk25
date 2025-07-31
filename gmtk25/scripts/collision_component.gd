extends Area2D

@onready var label: Label = $Label
var delta_sum : float = 0
signal change_level

func _ready() -> void:
	label.visible = false

func _input(event: InputEvent) -> void:
	if label.visible and event.is_action_pressed("interact"):
		change_level.emit()

func _on_area_entered(area: Area2D) -> void:
	label.visible = true

func _on_area_exited(area: Area2D) -> void:
	label.visible = false
