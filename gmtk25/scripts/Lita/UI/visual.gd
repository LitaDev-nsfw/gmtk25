extends VBoxContainer
class_name Visual

var texture: CompressedTexture2D
var reversableTexture: CompressedTexture2D
var fullscreenTexture: CompressedTexture2D
var text: String
const MaxImageSize := Vector2(800,500)

var fullscreen = false
func initialize():
	print(fullscreenTexture)
	if fullscreenTexture:
		print("TEST")
		$"Fullscreen Image".texture = fullscreenTexture
		$"Fullscreen Image".visible = true
		fullscreen = true
		#if fullscreenTexture.get_width() > fullscreenTexture.get_height():
		#	if fullscreenTexture.get_width() > get_viewport_rect().size.x:
		#		$"Fullscreen Image".scale *= float(get_viewport_rect().size.x)/float(fullscreenTexture.get_width())
		#else:
		#	if fullscreenTexture.get_height() > get_viewport_rect().size.y:
		#		$"Fullscreen Image".scale *= float(get_viewport_rect().size.y)/float(fullscreenTexture.get_height())
		return
	elif !texture:
		$PanelContainer.queue_free()
		
		custom_minimum_size.x = 500
	else:
		var SpriteNode = $PanelContainer/Sprite2D
		SpriteNode.texture = texture
		var sprite_size = SpriteNode.texture.get_size()
		var scaleFactor:= 1.0
		if sprite_size.y > MaxImageSize.y or sprite_size.x > MaxImageSize.x:
			if sprite_size.y > sprite_size.x:
				#print(MaxImageSize.y/sprite_size.y)
				scaleFactor = MaxImageSize.y/sprite_size.y
			else:
				scaleFactor = MaxImageSize.x/sprite_size.x
			#print(scaleFactor)
			SpriteNode.scale = Vector2(scaleFactor,scaleFactor)
		#print(sprite_size * scaleFactor)
		$PanelContainer.custom_minimum_size = sprite_size * scaleFactor
		SpriteNode.position = $PanelContainer.size/2
		if reversableTexture:
			$reversableButton.visible = true
	$Label.text = text


func _on_button_pressed():
	Globals.player_can_move = true
	Globals.player_can_interact = true
	get_tree().get_first_node_in_group("UI").change_blur(false)
	queue_free()
	

func _process(delta):
	if Input.is_action_just_pressed("close_visual") and fullscreen:
		Globals.player_can_interact = true
		Globals.player_can_move = true
		queue_free()
	pass

var reversed = false
func _on_flip():
	var SpriteNode = $PanelContainer/Sprite2D
	if !reversed:
		SpriteNode.texture = reversableTexture
	else:
		SpriteNode.texture = texture
	reversed = !reversed
