extends Node2D

var combination = 798

signal puzzle_solved
signal loop_level

func _ready() -> void:
	var it : int = 1
	for child : Number in get_children():
		child.change_text("-")
		it+= 1

func _on__check_combination() -> void:
	var str = ""
	for child : Number in get_children():
		str += child.get_text()
	
	if str == str(combination):
		puzzle_solved.emit()
