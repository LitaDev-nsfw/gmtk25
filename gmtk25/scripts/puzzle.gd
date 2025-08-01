extends Node2D

@export var puzzle : PackedScene
@onready var canvas_layer: CanvasLayer = $CanvasLayer
signal change_level
signal repeat_level

func _ready() -> void:
	if puzzle != null:
		var puzzle_scene = puzzle.instantiate()
		DisplayServer.window_get_size()
		get_viewport().get_visible_rect().size
		puzzle_scene.position = get_viewport().get_visible_rect().size / 2
		puzzle_scene.connect("puzzle_solved", _change_level)
		puzzle_scene.connect("loop_level", _repeat_level)
		
		canvas_layer.add_child(puzzle_scene)
		canvas_layer.get_child(0).hide()

func _on_collision_component_open_puzzle() -> void:
	canvas_layer.get_child(0).show()

func _on_collision_component_close_puzzle() -> void:
	canvas_layer.get_child(0).hide()

func _change_level():
	change_level.emit()

func _repeat_level():
	repeat_level.emit()
