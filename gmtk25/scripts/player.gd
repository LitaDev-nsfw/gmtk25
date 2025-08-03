extends CharacterBody2D
class_name Player
const SPEED = 400.0
@onready var label: Label = $Label
@onready var plank: Sprite2D = $Plank
@onready var plank_label: Label = $PlankLabel
var last_direction: Vector2 = Vector2.ZERO
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	EventSystem.connect("player_picked_up_plank", pick_up_plank)
	#EventSystem.connect("remove_player_planks", remove_planks)
	#EventSystem.connect("call_place_plank", place_plank)
	label.hide()
	plank.hide()
	plank_label.hide()
	deactivate_camera()
	
func _physics_process(delta: float) -> void:
	var direction : Vector2
	if Globals.player_can_move:
		direction = Input.get_vector("ui_left", "ui_right","ui_up","ui_down").normalized()
	else:
		direction = Vector2()
	#var direction_y := Input.get_axis("ui_up", "ui_down")
	
	#if direction and direction_y:
	#	direction /= 1.5
#		direction_y /= 1.5
	
	velocity += direction * SPEED
	if velocity.length() > SPEED:
		velocity = velocity.normalized()*SPEED
	
	#print(direction.length())
	if direction.length() == 0:
		velocity = velocity.move_toward(Vector2(), SPEED)
	
	if Globals.player_can_move:
		move_and_slide()
		
	if velocity != Vector2(0,0):
		last_direction = velocity
	
	#TODO, fix animations left and right
	if velocity.length() == 0:
		animated_sprite_2d.play("idle")
	elif direction.y >= 0:
		animated_sprite_2d.play("forward")
	elif velocity.y < 0:
		animated_sprite_2d.play("back")
		

# do some animation?
func _on_area_2d_area_entered(area: Area2D) -> void:
	pass

func reset_pos(pos) -> void:
	set_physics_process(false)
	collision_layer = 0
	var tween = create_tween()
	tween.tween_property(self, "position", pos, 0.5)
	await get_tree().create_timer(1).timeout
	set_physics_process(true)
	collision_layer = 1 
	
func show_label() -> void:
	Globals.player_can_move = true
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
	Globals.plank_count += 1
	plank.show()
	plank_label.show()
	plank_label.text = str(Globals.plank_count)

#func place_plank():
#	if Globals.plank_count > 0:
#		EventSystem.place_plank.emit(self.position, last_direction)
#		plank_count -= 1
#		plank_label.text = str(plank_count)
#		if plank_count == 0:
#			plank.hide()
#			plank_label.hide()

#func remove_planks():
#	plank_count = 0
#	plank_label.text = str(plank_count)
#	plank.hide()
#	plank_label.hide()
	
#func _input(event: InputEvent) -> void:
#	if event.is_action("place") and event.is_pressed():
#		place_plank()

func activate_camera() -> void:
	camera_2d.enabled = true

func deactivate_camera() -> void:
	camera_2d.enabled = false
