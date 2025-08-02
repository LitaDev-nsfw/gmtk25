extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()

	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")
	hide()
	

func pause():
	$AnimationPlayer.play("Blur")
	get_tree().paused = true
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


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta):
	escape()


func _on_settings_pressed() -> void:
	pass # Replace with function body.
