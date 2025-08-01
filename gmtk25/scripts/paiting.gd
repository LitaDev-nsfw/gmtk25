extends Node2D

signal puzzle_solved
signal loop_level
@onready var first_sprite: Sprite2D = $FirstSprite
@onready var second_sprite: Sprite2D = $SecondSprite

func _ready() -> void:
	first_sprite.show()
	second_sprite.hide()
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed: 
		modulate = Color.INDIAN_RED
		first_sprite.hide()
		second_sprite.show()

func _on_area_2d_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_area_2d_mouse_entered() -> void:
	modulate = Color.YELLOW
