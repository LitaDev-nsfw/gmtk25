extends Node2D

var combination = 3421

signal puzzle_solved

func _ready() -> void:
	var it : int = 1
	for child : Number in get_children():
		child.change_text(str(it))
		it+= 1

func _on__check_combination() -> void:
	var str = ""
	for child : Number in get_children():
		str += child.get_text()
	
	if str == str(combination):
		puzzle_solved.emit()
