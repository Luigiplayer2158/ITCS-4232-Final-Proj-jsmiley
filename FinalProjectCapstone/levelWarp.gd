extends Area

export var level_name = "";

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Hitbox_area_entered(area: Area) -> void:
	print("it has occured");
	get_tree().change_scene_to("res://"+ level_name + ".tscn");
