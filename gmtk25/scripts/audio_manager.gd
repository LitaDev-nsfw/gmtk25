extends Node
class_name AudioManager

const mute_db := -80.0 # To mute the audio player
const default_music_db := 0.0 # This is for normal volume
const fade_time := 2.0 # The time it takes to fade in/out in seconds
var current_music_player_layer1: AudioStreamPlayer # the current player
var current_music_player_layer2: AudioStreamPlayer # the current player
var layer2_started: bool = false
@onready var stream_1: AudioStreamPlayer = $Stream1
@onready var stream_2: AudioStreamPlayer = $Stream2
@onready var layer2: AudioStreamPlayer = $Layer2

#@onready var other_stream_layer_1: AudioStreamPlayer = $BackgroundMusic2_Layer1
#@onready var other_stream_layer_2: AudioStreamPlayer = $BackgroundMusic2_Layer2

func _ready() -> void:
	current_music_player_layer1 = stream_1
	current_music_player_layer2 = layer2

func fade_music_in(track: AudioStream) -> void:
	current_music_player_layer1.stream = track # Specify the song
	current_music_player_layer1.volume_db = mute_db # Mute the player
	current_music_player_layer1.play() # Start playing
	# Use tweens for transition:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player_layer1, "volume_db", default_music_db, fade_time)

func fade_music_out() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(current_music_player_layer1, "volume_db", mute_db, fade_time)
	#tween.tween_property(current_music_player_layer2, "volume_db", mute_db, fade_time)

func crossfade_music_to(track: AudioStream) -> void:
	fade_music_out() # Fade out first player
	
	# Switch current Player:
	current_music_player_layer1 = stream_1 if current_music_player_layer1 == stream_2 else stream_2
	#current_music_player_layer2 = stream_layer_2 if current_music_player_layer2 == stream_layer_1 else stream_layer_1
	fade_music_in(track) # Fade in second player

#var layer2_tween
#func fade_layer_in(track: AudioStream, time : float) -> void:
	#layer2_tween.kill()
	#current_music_player_layer2.stream = track # Specify the song
	#current_music_player_layer2.volume_db = mute_db # Mute the player
	#current_music_player_layer2.play() # Start playing
	## Use tweens for transition:
	#layer2_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	#layer2_tween.tween_property(current_music_player_layer2, "volume_db", default_music_db, time)	

var layer2_tween
func fade_layer_in(track: AudioStream) -> void:
	layer2_started = true
	current_music_player_layer2.stream = track # Specify the song
	current_music_player_layer2.volume_db = mute_db # Mute the player
	current_music_player_layer2.play() # Start playing
	# Use tweens for transition:
	#layer2_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	#layer2_tween.tween_property(current_music_player_layer2, "volume_db", default_music_db, 60)
