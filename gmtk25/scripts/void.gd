extends Node2D
@onready var area_2d: Area2D = $Area2D

func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		EventSystem.player_fell.emit()
	if body is PlacedPlank:
		queue_free()
