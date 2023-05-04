extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $"../Player/MovingPlayer"

onready var boxes = $"../HUD/boxes"

onready var deaths = $"../HUD/deaths"

onready var timer = $"../HUD/timer"

onready var saveMenu = $"../HUD/saveMenu"

onready var saveNode = $"../HUD/saveMenu/VBoxContainer/Save"

onready var npcText = $"../HUD/RichTextLabel"

export var doneOnce = false

# Called when the node enters the scene tree for the first time.
func _ready():
	boxes.visible = false
	deaths.visible = false
	timer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body is KinematicBody:
		if doneOnce == false:
			player.movementAllowed = false
			saveMenu.visible = true
			saveNode.grab_focus()
			$saveNPCguy/Area.monitoring = false
			doneOnce = true


func _on_Area_body_exited(body):
	if body is KinematicBody:
		doneOnce = false
		$saveNPCguy/Area.monitoring = true
