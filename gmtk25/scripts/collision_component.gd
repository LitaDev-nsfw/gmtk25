extends Area2D

@onready var label: Label = $Label
var delta_sum : float = 0
signal open_puzzle
signal close_puzzle

func _ready() -> void:
	label.visible = false

signal OnInteract

func _input(event: InputEvent) -> void:
	if get_overlapping_areas().size() > 0:
		if event.is_action_pressed("interact"):
			OnInteract.emit()
			open_puzzle.emit()
	if get_overlapping_areas().size() > 0 and event.is_action_pressed("escape"):
		close_puzzle.emit()

func _on_area_entered(area: Area2D) -> void:
	label.visible = true

func _on_area_exited(area: Area2D) -> void:
	label.visible = false
	close_puzzle.emit()
