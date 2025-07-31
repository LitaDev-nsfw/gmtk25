extends Area2D

@onready var label: Label = $Label

func _ready() -> void:
	label.visible = false 
	
func _process(delta: float) -> void:
	if has_overlapping_areas():
		label.visible = true
	else:
		label.visible = false

func _input(event: InputEvent) -> void:
	if label.visible and event.is_action_pressed("interact"):
		print("interact!")
