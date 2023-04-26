extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var spinSpeed = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	rotation.z += spinSpeed
	
