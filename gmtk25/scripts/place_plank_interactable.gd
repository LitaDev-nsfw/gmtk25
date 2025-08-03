extends Node2D
class_name PlacePlankInteractable
@onready var first_sprite: Sprite2D = $FirstSprite
@onready var dialog_box: Sprite2D = $DialogBox
@onready var area_2d: Area2D = $Area2D

var player_is_in : bool = false
func _ready() -> void:
	first_sprite.show()

func _on_yes_pressed() -> void:
	EventSystem.call_place_plank.emit()
	get_parent().get_parent()._on_collision_component_close_puzzle()
	get_parent().get_parent().queue_free()

func _on_no_pressed() -> void:
	first_sprite.hide()
	get_parent().get_parent()._on_collision_component_close_puzzle()
