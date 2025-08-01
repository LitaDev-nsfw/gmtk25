extends CharacterBody2D
class_name Player
const SPEED = 400.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	if direction and direction_y:
		velocity.x = velocity.x / 2
		velocity.y = velocity.y / 2
	
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
