extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if delta > 0.8:
		if self.modulate == Color.WHITE:
			self.modulate = Color.PINK
		else:
			self.modulate = Color.WHITE
