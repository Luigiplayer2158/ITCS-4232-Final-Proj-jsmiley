extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#https://docs.godotengine.org/en/3.0/getting_started/step_by_step/resources.html
#help with loading a resource in a node, this was helpful to autoload this node and also have the game data.
#https://godotengine.org/qa/16056/create-instance-of-custom-class
#help with instance of custom class, which is what gamedata is.

var newRuntimeData = preload("res://gameData.gd")
var runTimeData = newRuntimeData.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
