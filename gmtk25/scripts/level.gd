extends Node2D
class_name Level

signal change_level
signal repeat_level
signal add_time_to_loop
@onready var label : Label = $Label
@export var level_music_layer_1 : AudioStream = preload("res://assets/audio/music/Loop 1.wav")
@export var level_music_layer_2 : AudioStream = preload("res://assets/audio/music/Loop 2.wav")
var plank_scene : PackedScene = preload("res://scenes/placed_plank.tscn")
@onready var marker_2d: Marker2D = $Marker2D

func _ready() -> void:
	EventSystem.connect("place_plank", place_plank)
	if label: # set the level name for debugging
		label.text = name
		label.position = Vector2(920.0, 123)

# some action in the level will add time to the loop		
func add_time(added_time : int) -> void:
	add_time_to_loop.emit(added_time)

# called by each levels puzzle
func _change_level() -> void:
	change_level.emit() # will be recieved by game.gd

# called by each levels puzzle
func _repeat_level() -> void:
	repeat_level.emit() # will be recieved by game.gd

func place_plank(player_pos : Vector2, direction : Vector2 ) -> void:
	var plank = plank_scene.instantiate()
	plank.position = player_pos
	add_child(plank)
	var tween = create_tween()
	tween.tween_property(plank, "position", plank.position + (direction/3), 1)
