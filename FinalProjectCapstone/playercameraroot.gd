extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camerarotation_h = 0
	
# https://www.youtube.com/watch?v=Bch-OagnX1E&t=42s

func _physics_process(delta):
	rotation_degrees.y = camerarotation_h +180
