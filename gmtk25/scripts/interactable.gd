extends Node2D

@export var scene_to_load : PackedScene
@export var is_puzzle : bool = false

@onready var canvas_layer: CanvasLayer = $CanvasLayer
signal change_level
signal repeat_level
var child_scene : Node

func _ready() -> void:
	if scene_to_load != null:
		var scene = scene_to_load.instantiate()
		scene.position = get_viewport().get_visible_rect().size / 2
		if is_puzzle:
			scene.connect("puzzle_solved", _change_level)
			scene.connect("loop_level", _repeat_level)
		
		canvas_layer.add_child(scene)
		child_scene = canvas_layer.get_child(0)
		child_scene.hide()

func _on_collision_component_open_puzzle() -> void:
	child_scene._ready()
	child_scene.show()
	
	if child_scene.name == "Mirror":
		await get_tree().create_timer(5).timeout
		if child_scene.visible:
			hide_mirror()

func _on_collision_component_close_puzzle() -> void:
	child_scene.hide()

func _change_level():
	change_level.emit()

func _repeat_level():
	repeat_level.emit()

func hide_mirror():
	child_scene.hide()
	EventSystem.play_mirror_line.emit()
