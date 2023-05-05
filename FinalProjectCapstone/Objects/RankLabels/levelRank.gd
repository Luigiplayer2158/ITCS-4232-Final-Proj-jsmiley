extends Spatial

export var levelName = "level1rank"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rotAxisSpeed = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	$rankF.visible = false
	$rankD.visible = false
	$rankC.visible = false
	$rankB.visible = false
	$rankA.visible = false
	$rankS.visible = false

func _process(delta):
	if RuntimeGameData.runTimeData.get(levelName) == "F":
		$rankF.visible = true
	elif RuntimeGameData.runTimeData.get(levelName) == "D":
		$rankD.visible = true
	elif RuntimeGameData.runTimeData.get(levelName) == "C":
		$rankC.visible = true
	elif RuntimeGameData.runTimeData.get(levelName) == "B":
		$rankB.visible = true
	elif RuntimeGameData.runTimeData.get(levelName) == "A":
		$rankA.visible = true
	elif RuntimeGameData.runTimeData.get(levelName) == "S":
		$rankS.visible = true
	rotation.x = rotation.x + rotAxisSpeed
	if rotation.x < -0.33:
		rotAxisSpeed = 0.01
	elif rotation.x > 0.33:
		rotAxisSpeed = -0.01
