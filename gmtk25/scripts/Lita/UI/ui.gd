extends CanvasLayer

func _ready():
	add_to_group("UI")

@onready var VisualScene = preload("res://scenes/Lita/visual.tscn")

func load_visual(texture = null,text = "", reversable = null, fullscreen = null):
	print("test wawawaawa")
	change_blur(true)
	var visualNode: Visual = VisualScene.instantiate()
	if texture:
		visualNode.texture = texture
	visualNode.text = text
	if reversable:
		visualNode.reversableTexture = reversable
	if fullscreen:
		visualNode.fullscreenTexture = fullscreen
	visualNode.initialize()
	print(visualNode)
	add_child(visualNode)
	Globals.player_can_move = false
	Globals.player_can_interact = false

func start_lock_puzzle(puzzleNo: int):
	var lockPuzzle = load("res://scenes/Lita/lock_puzzle.tscn").instantiate()
	add_child(lockPuzzle)
	lockPuzzle.init(puzzleNo)
	lockPuzzle.puzzleSolved.connect(solvedLockPuzzle)

func solvedLockPuzzle(puzzleNo: int):
	match puzzleNo:
		1: Globals.solvedLock1 = true
		2: Globals.solvedLock2 = true
		3: Globals.solvedLock3 = true

#DOESN'T WORK FOR SOME REASON, IDFK
func change_blur(toggle: bool):
	if toggle:
		$BlurEffect.material.set_shader_parameter("LOD",2.5)
	else:
		$BlurEffect.material.set_shader_parameter("LOD",0)
	print($BlurEffect.material.get_shader_parameter("LOD"))
	
