extends VBoxContainer

var correctSolution: Array
var currentSolution: Array
var currentPuzzleNo: int
func init(puzzleNo:int):
	currentPuzzleNo = puzzleNo
	var lockSegmentScene = load("res://scenes/Lita/lockSegment.tscn")
	var i = 0
	match puzzleNo:
		1: 
			correctSolution = [1,8,2,3]
			currentSolution = [1,1,1,1]
			while i != 4:
				
				var lockSegmentNode: LockSegment = lockSegmentScene.instantiate()
				lockSegmentNode.type = "numbers"
				$LockSegments.add_child(lockSegmentNode)
				lockSegmentNode.valueChanged.connect(onSegmentValueChanged)
				lockSegmentNode.sequencePosition = i
				lockSegmentNode.scale *= .5
				i += 1
		2: 
			correctSolution = [5,8,3]
			currentSolution = [1,1,1]
			while i != 3:
				var lockSegmentNode: LockSegment = lockSegmentScene.instantiate()
				lockSegmentNode.type = "numbers"
				$LockSegments.add_child(lockSegmentNode)
				lockSegmentNode.valueChanged.connect(onSegmentValueChanged)
				lockSegmentNode.sequencePosition = i
				lockSegmentNode.scale *= .5
				i += 1
		3:
			correctSolution = [2,7,10,2]
			currentSolution = [1,1,1,1]
			while i != 4:
				var lockSegmentNode: LockSegment = lockSegmentScene.instantiate()
				lockSegmentNode.type = "numbers"
				$LockSegments.add_child(lockSegmentNode)
				lockSegmentNode.valueChanged.connect(onSegmentValueChanged)
				lockSegmentNode.sequencePosition = i
				lockSegmentNode.scale *= .5
				i += 1

signal puzzleSolved
func onSegmentValueChanged(value,sequencePosition):
	currentSolution[sequencePosition] = value+1
	for i in correctSolution:
		if i != currentSolution[correctSolution.find(i)]:
			return
	puzzleSolved.emit(currentPuzzleNo)
	queue_free()

func _on_button_pressed():
	queue_free()
	Globals.player_can_interact = true
	Globals.player_can_move = true
