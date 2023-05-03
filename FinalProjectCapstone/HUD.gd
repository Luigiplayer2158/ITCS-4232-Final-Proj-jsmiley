extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#https://youtu.be/l3rcG3mWy-U menu assistance
var paused = false
onready var deathCount = 0

onready var playerRespawnCoords = Vector3(0.00,5.00,0.00)

onready var player = $"../Player/MovingPlayer"

onready var anim = $ColorRect/AnimationPlayer

onready var pauseMenu = $pauseMenu

onready var firstNode = $pauseMenu/VBoxContainer/Resume

# Called when the node enters the scene tree for the first time.
func _ready():
	pauseMenu.visible = false
	anim.get_animation("fadeOut").set_loop(false)
	anim.get_animation("fadeIn").set_loop(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseGame()
		
func pauseGame():
	if get_tree().paused == true:
		get_tree().paused = false
		pauseMenu.visible = false
	else:
		get_tree().paused = true
		pauseMenu.visible = true
		firstNode.grab_focus()
	
func updateBoxes(boxCount):
	$boxes.text = "x " + str(boxCount)
	

func _on_Area_body_entered(body):
	if body is KinematicBody:
		playerDeath()
		

func playerDeath():
	print("it has occured");
	deathCount = deathCount + 1
	$deaths.text = "x " + str(deathCount)
	get_tree().paused = true
	anim.play("fadeOut")
	player.global_transform.origin = playerRespawnCoords
	get_tree().paused = false
	anim.play("fadeIn")
	
func checkpoint(newCoords):
	playerRespawnCoords = newCoords

func _on_Resume_pressed():
	get_tree().paused = false
	pauseMenu.visible = false

func _on_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_QuitToHub_pressed():
	get_tree().change_scene("res://Levels/Hub_1.tscn")
	get_tree().paused = false

func _on_QuitToDesktop_pressed():
	get_tree().quit()
