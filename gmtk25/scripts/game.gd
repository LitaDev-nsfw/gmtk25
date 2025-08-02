extends Node2D

var level1 : PackedScene = preload("res://scenes/level_1.tscn")
var level2 : PackedScene = preload("res://scenes/level_2.tscn")
var level3 : PackedScene = preload("res://scenes/level_3.tscn")
var level4 : PackedScene = preload("res://scenes/level_4.tscn")
var delta_sum : float = 0
@onready var level_1: Level = $Level1
@onready var player: Player = $Player
@onready var timer: Timer = $UI/Timer
@onready var color_rect: ColorRect = $Transition/ColorRect
@onready var label: Label = $UI/Timer/Label
#audio
@onready var wrong_level: AudioStreamPlayer = $Audio/WrongLevel
@onready var correct_level: AudioStreamPlayer = $Audio/CorrectLevel
@onready var loop_sound: AudioStreamPlayer = $Audio/LoopSound
@onready var audio_manager: AudioManager = $Audio

func _ready() -> void:
	EventSystem.connect("play_mirror_line", show_player_label)
	EventSystem.connect("player_fell", _repeat_level)
	
	level_1.connect("change_level", _on_player_change_level)
	level_1.connect("repeat_level", _repeat_level)
	level_1.connect("add_time_to_loop", update_loop_time)
	audio_manager.fade_music_in(level_1.level_music_layer_1)
	audio_manager.fade_layer_in(level_1.level_music_layer_2)

func _process(delta: float) -> void:
	delta_sum += delta
	if delta_sum >= 0.5:
		delta_sum = 0
		var time_left = int(timer.time_left)
		label.text = str(time_left)
		var time = remap(time_left, 60, 0, -40, 0)
		var volume = clamp(time, -80, 0)
		audio_manager.current_music_player_layer2.volume_db = volume
		#if not audio_manager.layer2_started:
		#audio_manager.fade_layer_in(level_1.level_music_layer_2)
		
func _on_player_change_level() -> void:
	var current_level = find_level()
	var current_level_name = current_level.name
	if current_level:
		var next_level : Level = null
		
		# there will be special logic in some cases, ie, go from lvl2 to lvl2 again.
		match (current_level_name):
			"Level1":
				next_level = create_next_level(level4)
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
	var next_level = create_next_level(level1)
	
	if current_level != null and next_level != null:
		next_level.name = "Level1"
		transition(next_level, current_level)
	
	EventSystem.remove_player_planks.emit()

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

func transition(next_level : Node, current_level : Node) -> void: 
	if current_level != null and next_level != null:
		loop_sound.play()
		transition_songs(next_level, current_level)
		var tween = create_tween().set_parallel()
		tween.tween_property(color_rect, "modulate", Color.BLACK, 2)
		tween.tween_property(color_rect, "scale", Vector2(5,5), 2)
		tween.tween_property(color_rect, "position", Vector2(-1000, -1000), 1.5)
		await tween.finished
		player.reset_pos()
		if current_level != null and next_level != null:
			remove_child(current_level)
			current_level.queue_free()
			call_deferred("add_child", next_level)
			await get_tree().create_timer(0.5).timeout
			color_rect.position = Vector2(0,0)
			tween = create_tween().set_parallel()
			tween.tween_property(color_rect, "modulate", Color.TRANSPARENT, 1.5)
			tween.tween_property(color_rect, "scale", Vector2(1,1), 1.5)

func transition_songs(next_level : Node, current_level : Node) -> void: 
	if current_level != null and next_level != null:
		if next_level.name != current_level.name:
			audio_manager.crossfade_music_to(next_level.level_music_layer_1)
			audio_manager.fade_layer_in(next_level.level_music_layer_2)
		else :
			audio_manager.crossfade_music_to(current_level.level_music_layer_1)
			audio_manager.fade_layer_in(current_level.level_music_layer_2)
		
func show_player_label():
	player.show_label()
