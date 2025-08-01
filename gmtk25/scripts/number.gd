extends Sprite2D
class_name Number

@onready var label: Label = $Label
var reading : bool = false
signal check_combination

func _ready() -> void:
	label.text = ""

func change_text(new_text : String) -> void:
	label.text = new_text

func get_text() -> String:
	return label.text
	
func _input(event: InputEvent) -> void:
	if reading:
		if event is InputEventKey:
			reading = false
			modulate = Color.WHITE
			var selected_key = event.as_text()
			if len(selected_key) == 1:
				change_text(event.as_text())
				check_combination.emit()
		
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and reading == false:
		reading = true
		modulate = Color.YELLOW
		await get_tree().create_timer(5).timeout
		reading = false
		modulate = Color.WHITE
		
func _on_area_2d_mouse_entered() -> void:
	modulate = Color.GREEN

func _on_area_2d_mouse_exited() -> void:
	if not reading:
		modulate = Color.WHITE
