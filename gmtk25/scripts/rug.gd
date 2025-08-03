extends Node2D

@onready var first_sprite: Sprite2D = $FirstSprite
@onready var dialog_box: Sprite2D = $DialogBox

func _ready() -> void:
	first_sprite.show()
	dialog_box.show()

func _on_yes_pressed() -> void:
	get_parent().get_parent()._on_collision_component_close_puzzle()
	get_parent().get_parent().queue_free()

func _on_no_pressed() -> void:
	first_sprite.hide()
	dialog_box.hide()
	get_parent().get_parent()._on_collision_component_close_puzzle()
