extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var spinSpeed = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.y += spinSpeed



func _on_Area_body_entered(body):
	print("it has occured");


#func _on_Area_body_exited(body):
	#print("it has occured");

