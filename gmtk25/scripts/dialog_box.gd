extends Sprite2D

@onready var label: Label = $Label
@export var dialog : Array[String] = ["first", "second", "third", "fourth"]
var it : int = 1

func _ready() -> void:
	label.text = dialog[0]
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if dialog.size() - it > 0:
			label.text = dialog[it]
			it+= 1
