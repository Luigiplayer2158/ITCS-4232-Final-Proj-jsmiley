extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var HUD = $"../../HUD"

onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.get_animation("SpikeBlockMotion").set_loop(true)
	anim.play("SpikeBlockMotion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body is KinematicBody:
		HUD.playerDeath()
