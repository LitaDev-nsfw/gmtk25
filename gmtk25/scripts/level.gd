extends Node2D
class_name Level

signal change_level
signal repeat_level
signal add_time_to_loop
@export var level_music_layer_1 : AudioStream = preload("res://assets/audio/music/Loop 1.wav")
@export var level_music_layer_2 : AudioStream = preload("res://assets/audio/music/Loop 2.wav")
var plank_scene : PackedScene = preload("res://scenes/placed_plank.tscn")
@onready var marker_2d: Marker2D = $Marker2D

func _ready() -> void:
	EventSystem.connect("place_plank", place_plank)
	for node in get_children():
		if node is Interactable:
			print(node.name)
			print(Vector2(207,100) * node.scale)
			node.OnInteract.connect(on_interact)

func connectInteractables():
	for node in get_children():
		if node is Interactable:
			node.OnInteract.connect(on_interact)

func _process(delta):
	if Globals.solvedLock1 and find_child("Level1Door"):
		find_child("Level1Door").queue_free()
	if Globals.solvedLock2 and find_child("Level2Door"):
		find_child("Level2Door").queue_free()
	if Globals.solvedLock3 and find_child("Level3Door"):
		find_child("Level3Door").queue_free()


func on_interact(node: Interactable):
	if (node.one_time and node.finished) or !Globals.player_can_interact:
		return
	match node.interactable_name:
		"level1Rug": node.position -= Vector2(200,-20); node.rotate(-.25*PI)
		"level1Easel": 
			#print("test1")
			if node.find_child("ClothOverEasel"):
				#print("test2")
				node.find_child("ClothOverEasel").queue_free()
			else:
				#print("test1")
				LoadVisual.emit(load("res://assets/visuals/Saturn_Painting.png"), "Saturn Devouring his Son.\nFrancisco Goya, 1823")
		"level1ClockPainting":
			LoadVisual.emit(load("res://assets/visuals/Clock_Painting.png"), "PLACEHOLDER CLOCK PAINTING TEXT")
		"level1AtroposPainting":
			LoadVisual.emit(load("res://assets/visuals/Atropos_Painting.png"), "PLACEHOLDER ATROPOS TEXT")
		"level1Journal":
			LoadVisual.emit(null,"PLACEHOLDER JOURNAL TEXT")
		"level1LockedDoor":
			if not Globals.solvedLock1:
				StartLockPuzzle.emit(1)
			else:
				change_level.emit()
		"level2LockedDoor":
			if not Globals.solvedLock2:
				StartLockPuzzle.emit(2)
			else:
				change_level.emit()
		"level2Cobweb":
			LoadVisual.emit(null, "", null, load("res://assets/visuals/ART/GMTK game jam 25/cobweb room 3.png"))
		"level2KidsBlocks":
			LoadVisual.emit(null,"",null, load("res://assets/visuals/ART/GMTK game jam 25/blocks r2.png"))
		"level2Mirror":
			LoadVisual.emit(null,"When mirrored, the cracks on the wall look like a 5.")
		"level2Cracks":
			LoadVisual.emit(null,"The cracks in the wall look like a 2.")
		"level2Drawer":
			LoadVisual.emit(null,"Once upon a time, there was a young man who lived in a mirror. He could do nothing but watch the people who lived in his house, and he slowly grew bored with their daily routines. That is until one day, a young child arrived and changed everything. She was the most fun to watch, she was always playing with her toys and laughing, but the most special change was that she would talk to him. Every day, she would come up to him and tell him about what she had been doing. Over time, the man grew to care deeply for the girl. He watched her grow over the years, older and older, but no matter how old she got, she would come talk to him. The man thought how lucky he was that someone finally noticed he was in there. The next day, the woman came to speak to him, and he noticed just how old she had gotten. She told him how happy she was that she had someone to talk to, even if it was just herself, but she wasn't going to be able to visit anymore, so it was time to say goodbye. The man was heartbroken. He never saw the woman again, and some man he had never met before came to move him into a new room. No one came to this room. His only friends now were the spiders spinning their webs.")
		"level3LockedDoor":
			if not Globals.solvedLock3:
				StartLockPuzzle.emit(3)
			else:
				change_level.emit()
		"level3Wardrobe":
			LoadVisual.emit(load("res://assets/visuals/ART/GMTK game jam 25/photos/photo 1.png"),"",load("res://assets/visuals/ART/GMTK game jam 25/photos/photo1.1.png"))
		"level3Drawer1":
			LoadVisual.emit(load("res://assets/visuals/ART/GMTK game jam 25/photos/photo2.png"),"",load("res://assets/visuals/ART/GMTK game jam 25/photos/photo2.1.png"))
		"level3Drawer2":
			LoadVisual.emit(load("res://assets/visuals/ART/GMTK game jam 25/photos/photo3.png"),"")
		"level3Cabinet":
			LoadVisual.emit(load("res://assets/visuals/ART/GMTK game jam 25/photos/photo4 .png"),"",load("res://assets/visuals/ART/GMTK game jam 25/photos/photo4.1.png"))
		"level4Plank1":
			print("test12")
			place_plank(find_child("PlankVoid1",true))
		"level4Plank2":
			place_plank(find_child("PlankVoid2",true))
		"level4Plank3":
			place_plank(find_child("PlankVoid3",true))
		"level4Door":
			change_level.emit()
		"level4Planks1":
			LoadVisual.emit(null,"You find two sturdy planks.")
			Globals.plankCount += 2
			find_child("Special Collision",true).queue_free()
			find_child("PlanksLeaningAgainstBedR4",true).queue_free()
		"level4Planks2":
			LoadVisual.emit(null,"You manage to find one more usable board amongst the rotten heap.")
			Globals.plankCount += 1
		_: push_warning("Invalid Interactable")
		
	node.finished = true
signal StartLockPuzzle
signal LoadVisual


# some action in the level will add time to the loop		
func add_time(added_time : int) -> void:
	add_time_to_loop.emit(added_time)

# called by each levels puzzle
func _change_level() -> void:
	change_level.emit() # will be recieved by game.gd

# called by each levels puzzle
func _repeat_level() -> void:
	repeat_level.emit() # will be recieved by game.gd

func place_plank(CollisionShape) -> void:
	print("test123")
	Globals.plankCount -= 1
	var oldPosition = CollisionShape.global_position
	var sprite = Sprite2D.new()
	sprite.texture = load("res://assets/visuals/ART/GMTK game jam 25/plank hanging off into void r4.png")
	sprite.rotate(.4*PI)
	sprite.scale *= 1.5
	add_child(sprite)
	sprite.global_position = oldPosition
	sprite.position.y += 30
	CollisionShape.queue_free()
