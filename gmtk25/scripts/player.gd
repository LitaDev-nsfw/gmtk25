extends CharacterBody2D
class_name Player
const SPEED = 400.0
@onready var label: Label = $Label
@onready var plank: Sprite2D = $Plank
@onready var plank_label: Label = $PlankLabel
var plank_count : int = 0

func _ready() -> void:
	EventSystem.connect("player_picked_up_plank", pick_up_plank)
	EventSystem.connect("remove_player_planks", remove_planks)
	label.hide()
	plank.hide()
	plank_label.hide()
	
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
	
	if Globals.player_can_move:
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

func pick_up_plank():
	plank_count += 1
	plank.show()
	plank_label.show()
	plank_label.text = str(plank_count)

func place_plank():
	plank_count -= 1
	plank_label.text = str(plank_count)
	if plank_count == 0:
		plank.hide()
		plank_label.hide()

func remove_planks():
	plank_count = 0
	plank_label.text = str(plank_count)
	plank.hide()
	plank_label.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action("place"):
		place_plank()
