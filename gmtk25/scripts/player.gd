extends CharacterBody2D
class_name Player
const SPEED = 400.0
@onready var label: Label = $Label

func _ready() -> void:
	label.hide()
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	if direction and direction_y:
		direction /= 1.5
		direction_y /= 1.5
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

# do some animation?
func _on_area_2d_area_entered(area: Area2D) -> void:
	pass

func reset_pos() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(150, 150), 0.5)
	
func show_label() -> void:
	label.text = ""
	label.show()
	var tween = create_tween()
	await tween.tween_property(label,"text", "I can't look at it no more...", 3).finished
	await get_tree().create_timer(3).timeout
	tween = create_tween()
	await tween.tween_property(label, "modulate", Color.TRANSPARENT, 2).finished
	label.hide()
	label.modulate = Color.WHITE
