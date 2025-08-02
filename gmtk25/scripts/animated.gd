extends Node2D

@onready var alarm_clock: Sprite2D = $AlarmClock
@onready var wall_clock: Sprite2D = $WallClock
@onready var water: Sprite2D = $Water
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var animation_player_3: AnimationPlayer = $AnimationPlayer3

func _ready() -> void:
	animation_player.play("alarm_smash")
	animation_player_2.play("water")
	animation_player_3.play("wall_clock")
	await get_tree().create_timer(10).timeout
	animation_player.play_backwards("alarm_smash")
	animation_player_2.play_backwards("water")
	animation_player_3.play_backwards("wall_clock")
