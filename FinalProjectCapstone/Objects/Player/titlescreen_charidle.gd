extends Spatial

onready var anim = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.get_animation("TitleScreen").set_loop(true)
	anim.play("TitleScreen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
