extends Node2D

@onready var first_sprite: Sprite2D = $FirstSprite
@onready var dialog_box: Sprite2D = $DialogBox

func _ready() -> void:
	first_sprite.show()
	dialog_box.show()
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("interact")  and event.pressed: 
		EventSystem.place_plank.emit()
		queue_free()
