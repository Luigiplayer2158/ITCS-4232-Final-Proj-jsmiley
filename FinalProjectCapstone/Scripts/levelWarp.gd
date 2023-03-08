extends Spatial

export (String) var level_name = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area_body_entered(body):
	print("it has occured");
	get_tree().change_scene("res://Levels/"+ level_name + ".tscn");
