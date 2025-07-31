extends Node2D

var level1 : PackedScene = preload("res://scenes/level_1.tscn")
var level2 : PackedScene = preload("res://scenes/level_1.tscn")
var level3 : PackedScene = preload("res://scenes/level_1.tscn")
var level4 : PackedScene = preload("res://scenes/level_1.tscn")

@onready var player: CharacterBody2D = $Player
func _on_player_change_level() -> void:
	var current_level = find_level()
	if current_level:
		remove_child(current_level)
		var level_node = null
		## logic to decide the next level
		match (current_level.name):
			"Level1":
				level_node = level1.instantiate()
			"Level2":
				pass
			"Level3":
				pass
			"Level4":
				pass
		
		if level_node:
			call_deferred("add_child", level_node)
			player.reset_pos()

func find_level() -> Node:
	var my_level_idx = get_children().find_custom(is_level.bind())
	return get_children().get(my_level_idx)

func is_level(el: Node) -> bool:
	return el.name.contains("Level")
