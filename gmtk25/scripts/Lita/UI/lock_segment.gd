extends Control
class_name LockSegment

var type: String:
	set(newValue):
		type = newValue
		$AnimatedSprite2D.animation = type

signal valueChanged

var sequencePosition: int

var value:= 0:
	set(newValue):
		
		value = newValue
		match type:
			"numbers": 
				if value < 0: 
					value = 9 
				elif value > 9: 
					value = 0
			"letters": 
				if value < 0: 
					value = 6
				elif value > 6: 
					value = 0;
		$AnimatedSprite2D.frame = value
		valueChanged.emit(value, sequencePosition)

func _ready():
	type = "numbers"

func _on_up_pressed():
	value -= 1


func _on_down_pressed():
	value += 1
