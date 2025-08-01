extends Node2D

func _on_open_puzzle() -> void:
	EventSystem.player_picked_up_plank.emit()
	queue_free()
