extends Node2D

@export var combination = 1823
@export var wrong_combination : Array[String]= ["1931"]

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
	elif str in wrong_combination:
		loop_level.emit()
