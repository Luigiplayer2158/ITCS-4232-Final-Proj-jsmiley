extends Spatial

export (String) var level_name = "";
var scaleModif = 0.05;
var portal_enabled = false;
var enable_grow = false;

onready var portalArea = $Area
# https://www.youtube.com/watch?v=2yPdNEhfBGw level switcher help
# Called when the node enters the scene tree for the first time.
func _ready():
	portal_enabled = false;
	enable_grow = false;
	portalArea.scale.x = 0
	portalArea.scale.y = 0
	portalArea.scale.z = 0

func _physics_process(delta):
	portalArea.rotation.y += 0.2
	if enable_grow == true:
		portalArea.scale.y += scaleModif
		portalArea.scale.x += scaleModif
		portalArea.scale.z += scaleModif
		if portalArea.scale.y > 1:
			portal_enabled = true
			scaleModif = 0
		elif portalArea.scale.y <= 0:
			scaleModif = 0.05
	

func _on_Area_body_entered(body):
	if body is KinematicBody:
		print("it has occured");
		if portal_enabled == true:
			get_tree().change_scene("res://Levels/"+ level_name + ".tscn");


func _on_Area2_body_entered(body):
	if body is KinematicBody:
		print("area entered, effect should grow.")
		enable_grow = true
	
