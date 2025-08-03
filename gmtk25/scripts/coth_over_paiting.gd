extends Node2D

@onready var first_sprite: Sprite2D = $FirstSprite
@onready var dialog_box: Sprite2D = $DialogBox
var saturn_scene : PackedScene  = preload("res://scenes/Saturn.tscn")
func _ready() -> void:
	first_sprite.show()
	dialog_box.show()

func _on_yes_pressed() -> void:
	var saturn = saturn_scene.instantiate()
	saturn.position = get_viewport().get_visible_rect().size / 2
	get_parent().add_child(saturn)
	get_parent().get_parent().child_scene = saturn
	get_parent().get_parent().remove_child(get_parent().get_parent().find_child("ClothOverEasel"))
	queue_free()
	get_parent().get_parent()._on_collision_component_close_puzzle()

func _on_no_pressed() -> void:
	first_sprite.hide()
	dialog_box.hide()
	get_parent().get_parent()._on_collision_component_close_puzzle()
