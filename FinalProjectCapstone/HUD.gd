extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var deathCount = 0

onready var playerRespawnCoords = Vector3(0.00,5.00,0.00)

onready var player = $"../Player/MovingPlayer"

onready var anim = $ColorRect/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():

	anim.get_animation("fadeOut").set_loop(false)
	anim.get_animation("fadeIn").set_loop(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
