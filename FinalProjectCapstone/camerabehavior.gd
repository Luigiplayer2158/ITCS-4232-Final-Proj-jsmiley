extends SpringArm


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var CameraRotTypeMin = 0
export var CameraRotTypeMax = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees.y = clamp(rotation.y, CameraRotTypeMin, CameraRotTypeMax)
