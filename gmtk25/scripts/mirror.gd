extends Node2D

signal puzzle_solved
signal loop_level
@onready var first_sprite: Sprite2D = $FirstSprite
@onready var second_sprite: Sprite2D = $SecondSprite
@onready var dialog_box: Sprite2D = $DialogBox
@onready var timer: Timer = $Timer

func _ready() -> void:
	first_sprite.show()
	second_sprite.hide()
	dialog_box.hide()
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed: 
		timer.start()
		modulate = Color.INDIAN_RED
		first_sprite.hide()
		second_sprite.show()
		dialog_box.show()
			
func _on_area_2d_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_area_2d_mouse_entered() -> void:
	modulate = Color.YELLOW


func _on_timer_timeout() -> void:
	print("I cant look at it no more")
	get_parent().get_parent().hide_mirror()
	get_parent().get_parent().get_parent().get_parent().show_player_label()
	timer.stop()
	
