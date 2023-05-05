extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var spinSpeed = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#https://godotengine.org/article/godot-31-will-get-many-improvements-kinematicbody/
#this article showed that adding a kinematic body will fix the issue of platforms not carrying player movement,
#but physics and movement have to be done on the kinematic body for it to work.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$KinematicBody.rotation.y += spinSpeed



func _on_Area_body_entered(_body):
	print("it has occured");


#func _on_Area_body_exited(body):
	#print("it has occured");

