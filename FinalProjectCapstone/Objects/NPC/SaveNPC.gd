extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $"../Player/MovingPlayer"

onready var deaths = $"../HUD/deaths"

onready var saveMenu = $"../HUD/saveMenu"

onready var saveNode = $"../HUD/saveMenu/VBoxContainer/Save"

onready var npcText = $"../HUD/saveMenu/RichTextLabel"

onready var hud = $"../HUD"

export var doneOnce = false

# Called when the node enters the scene tree for the first time.
func _ready():
	deaths.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body is KinematicBody:
		if doneOnce == false:
			player.movementAllowed = false
			hud.pauseAllowed = false
			saveMenu.visible = true
			saveNode.grab_focus()
			$saveNPCguy/Area.monitoring = false
			doneOnce = true


func _on_Area_body_exited(body):
	if body is KinematicBody:
		saveNode.release_focus()
		hud.pauseAllowed = true
		doneOnce = false
		$saveNPCguy/Area.monitoring = true
