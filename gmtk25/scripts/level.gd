extends Node2D
class_name Level

signal change_level
signal repeat_level
signal add_time_to_loop
@onready var label : Label = $Label
@export var level_music_layer_1 : AudioStream = preload("res://assets/audio/music/Loop 1.wav")
@export var level_music_layer_2 : AudioStream = preload("res://assets/audio/music/Loop 2.wav")

func _ready() -> void:
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
