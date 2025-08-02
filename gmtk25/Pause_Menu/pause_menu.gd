extends Control
@onready var settings: Control = $"../Settings"
@onready var pause_menu: Control = $"."

func _ready():
	$AnimationPlayer.play("RESET")
	settings.visible = false
	hide()

	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")
	hide()
	settings.visible = false

	

func pause():
	$AnimationPlayer.play("Blur")
	get_tree().paused = true
	settings.visible = false
	show()
	

	

func escape():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
	
func _on_settings_pressed() -> void:
	settings.visible = true
	pause_menu.visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta):
	escape()
