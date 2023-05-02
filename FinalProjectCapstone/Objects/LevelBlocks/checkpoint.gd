extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var HUD = $"../../HUD"

export var checkpointCoords = Vector3(0.00, 0.00, 0.00)

onready var pinHeadMaterial = $head.get_surface_material(0)
#https://godotforums.org/d/21600-is-there-a-way-to-change-what-material-an-object-is-using-using-a-script
#Help with changing object material within the game.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body is KinematicBody:
		HUD.checkpoint(checkpointCoords)
		pinHeadMaterial.albedo_color = Color(0.00, 0.00, 1.00)
