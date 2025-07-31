extends Node2D

var level1 : PackedScene = preload("res://scenes/level_1.tscn")
var level2 : PackedScene = preload("res://scenes/level_2.tscn")
var level3 : PackedScene = preload("res://scenes/level_3.tscn")
var level4 : PackedScene = preload("res://scenes/level_4.tscn")
@onready var level_1: Level = $Level1

@onready var player: Player = $Player
@onready var timer: Timer = $UI/Timer

func _ready() -> void:
	level_1.connect("change_level", _on_player_change_level)
	level_1.connect("add_time_to_loop", update_loop_time)
	
func _on_player_change_level() -> void:
	var current_level = find_level()
	if current_level:
		remove_child(current_level)
		var level_node : Level = null
		## logic to decide the next level
		match (current_level.name):
			"Level1":
				level_node = create_next_level(level2)
			"Level2":
				level_node = create_next_level(level3)
			"Level3":
				level_node = create_next_level(level4)
			"Level4":
				level_node = create_next_level(level1)
		
		if level_node:
			call_deferred("add_child", level_node)
			player.reset_pos()

func create_next_level(level_scene : PackedScene) -> Level:
	var level : Level = level_scene.instantiate()
	level.connect("change_level", _on_player_change_level)
	level.connect("add_time_to_loop", update_loop_time)
	return level
	
func find_level() -> Node:
	var my_level_idx = get_children().find_custom(is_level.bind())
	return get_children().get(my_level_idx)

func is_level(el: Node) -> bool:
	return el.name.contains("Level")

func _on_timer_timeout() -> void:
	# TODO, this will get more complicated as we add more puzzles because we may need to reset some variables later.
	var level_node = level1.instantiate()
	level_node.name = "Level-1"
	call_deferred("add_child", level_node)
	player.reset_pos()

func update_loop_time(added_time : int) -> void:
	timer.wait_time += added_time # TODO, this will only add time to the total timer, the current loop wont be affected
