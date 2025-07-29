extends Label
var sum : float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sum += delta
	if sum > 0.8:
		sum = 0
		if self.modulate == Color.WHITE:
			self.modulate = Color.GREEN
		else:
			self.modulate = Color.WHITE
