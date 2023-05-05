extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $"../Player/MovingPlayer"

onready var deaths = $"../HUD/deaths"

onready var saveMenu = $"../HUD/saveMenu"

onready var saveNode = $"../HUD/saveMenu/VBoxContainer/Save"

onready var npcText = $"../HUD/saveMenu/RichTextLabel"

onready var wantToSave = preload("res://Sounds/VoiceClips/adventurer_doYouWantToSave.ogg")
onready var seeYouLater = preload("res://Sounds/VoiceClips/adventurer_seeYouLater.ogg")

onready var hud = $"../HUD"

export var doneOnce = false

# Called when the node enters the scene tree for the first time.
func _ready():
	deaths.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#https://www.youtube.com/watch?v=YiLPo72GZs0
#https://godotengine.org/qa/88590/correct-way-to-load-and-play-sounds-from-code
#https://www.reddit.com/r/godot/comments/ljt4xk/how_to_play_a_sound_effect_once_without_looping/
#help with sounds and music

func _on_Area_body_entered(body):
	if body is KinematicBody:
		if doneOnce == false:
			player.movementAllowed = false
			hud.pauseAllowed = false
			saveMenu.visible = true
			saveNode.grab_focus()
			$AudioStreamPlayer.stream = wantToSave
			$AudioStreamPlayer.stream.loop = false
			$AudioStreamPlayer.play()
			$saveNPCguy/Area.monitoring = false
			doneOnce = true


func _on_Area_body_exited(body):
	if body is KinematicBody:
		saveNode.release_focus()
		hud.pauseAllowed = true
		doneOnce = false
		$AudioStreamPlayer.stream = seeYouLater
		$AudioStreamPlayer.stream.loop = false
		$AudioStreamPlayer.play()
		$saveNPCguy/Area.monitoring = true
