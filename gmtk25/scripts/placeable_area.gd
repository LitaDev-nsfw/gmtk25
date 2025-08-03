extends Node2D
class_name PlaceableArea

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlacedPlank:
		body.position = position
		queue_free()
