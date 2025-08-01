extends Node2D

var level1 : PackedScene = preload("res://scenes/level_1.tscn")
var level2 : PackedScene = preload("res://scenes/level_2.tscn")
var level3 : PackedScene = preload("res://scenes/level_3.tscn")
var level4 : PackedScene = preload("res://scenes/level_4.tscn")
@onready var level_1: Level = $Level1
@onready var player: Player = $Player
@onready var timer: Timer = $UI/Timer
@onready var color_rect: ColorRect = $Transition/ColorRect
#audio
@onready var wrong_level: AudioStreamPlayer = $Audio/WrongLevel
@onready var correct_level: AudioStreamPlayer = $Audio/CorrectLevel
@onready var loop_sound: AudioStreamPlayer = $Audio/LoopSound
@onready var background_music: AudioStreamPlayer = $Audio/BackgroundMusic

func _ready() -> void:
	level_1.connect("change_level", _on_player_change_level)
	level_1.connect("repeat_level", _repeat_level)
	level_1.connect("add_time_to_loop", update_loop_time)
	
func _on_player_change_level() -> void:
	var current_level = find_level()
	var current_level_name = current_level.name
	if current_level:
		var next_level : Level = null
		
		# there will be special logic in some cases, ie, go from lvl2 to lvl2 again.
		match (current_level_name):
			"Level1":
				next_level = create_next_level(level2)
			"Level2":
				next_level = create_next_level(level3)
			"Level3":
				next_level = create_next_level(level4)
			"Level4":
				next_level = create_next_level(level1)
		
		if next_level != null:
			transition(next_level, current_level)
			correct_level.play()

func create_next_level(level_scene : PackedScene) -> Level:
	var level : Level = level_scene.instantiate()
	level.connect("change_level", _on_player_change_level)
	level.connect("repeat_level", _repeat_level)
	level.connect("add_time_to_loop", update_loop_time)
	return level
	
func find_level() -> Node:
	var my_level_idx = get_children().find_custom(is_level.bind())
	return get_children().get(my_level_idx)

func is_level(el: Node) -> bool:
	return el.name.contains("Level")

# loop has ended
func _on_timer_timeout() -> void:
	# TODO, this will get more complicated as we add more puzzles because we may need to reset some variables later.
	var current_level : Node = find_level()
	if current_level:
		remove_child(current_level)
		current_level.queue_free()
		
	var next_level = level1.instantiate()
	next_level.name = "Level1"
	transition(next_level, current_level)
	loop_sound.play()

func update_loop_time(added_time : int) -> void:
	timer.wait_time += added_time # TODO, this will only add time to the total timer, the current loop wont be affected

func _repeat_level() -> void:
	var current_level : Node = find_level()
	var current_level_name = current_level.name
	if current_level:
		var next_level : Level = null
		
		match (current_level_name):
			"Level1":
				next_level = create_next_level(level1)
			"Level2":
				next_level = create_next_level(level1)
			"Level3":
				next_level = create_next_level(level2)
			"Level4":
				next_level = create_next_level(level2)
		
		if next_level != null:
			transition(next_level, current_level)
			wrong_level.play()

func transition(next_level : Node, current_level : Node): 
	var tween = create_tween().set_parallel()
	tween.tween_property(color_rect, "modulate", Color.BLACK, 2)
	tween.tween_property(color_rect, "scale", Vector2(5,5), 2)
	tween.tween_property(color_rect, "position", Vector2(-1000, -1000), 1.5)
	await tween.finished
	
	player.reset_pos()
	call_deferred("add_child", next_level)
	remove_child(current_level)
	current_level.queue_free()
	await get_tree().create_timer(0.5).timeout
	color_rect.position = Vector2(0,0)
	tween = create_tween().set_parallel()
	tween.tween_property(color_rect, "modulate", Color.TRANSPARENT, 1.5)
	tween.tween_property(color_rect, "scale", Vector2(1,1), 1.5)
			
	await tween.finished
