extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var HUD = $"../HUD"

onready var player = $"../Player"

onready var villain = $"../villainHenchmanGuy"

onready var anim = $AnimationPlayer

export var phase = 1
export var canTakeDamage = true
export var villainHealth = 3
var doOnce = true
var playingAllowed = true
var hasntAttacked = true

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.get_animation("bossSpikesR-L").set_loop(false)
	anim.get_animation("bossSpikesL-R").set_loop(false)
	anim.get_animation("bossSpikesForward").set_loop(false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if villainHealth == 0:
		if doOnce == true:
			$"../villainHenchmanGuy/AnimationPlayer".play("bossDefeat")
			doOnce = false
			playingAllowed = false
	
	if canTakeDamage == false:
		if villainHealth != 0:
			$"../Player/MovingPlayer".global_transform.origin = Vector3(0.00,1.00,0.00)
			canTakeDamage = true
	
	if $"../villainHenchmanGuy/AnimationPlayer".is_playing():
		pass
	else:
		if playingAllowed == true:
			$"../villainHenchmanGuy/AnimationPlayer".play("idle001")
	
	if phase == 1:
		if hasntAttacked:
			hasntAttacked = false
			yield(get_tree().create_timer(4), "timeout")
			playingAllowed = false
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActR-L")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesL-R")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			playingAllowed = true
			yield(get_tree().create_timer(10), "timeout")
		else:
			yield(get_tree().create_timer(30), "timeout")
			hasntAttacked = true
	elif phase == 2:
		if hasntAttacked:
			hasntAttacked = false
			yield(get_tree().create_timer(4), "timeout")
			playingAllowed = false
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActR-L")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesL-R")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			playingAllowed = true
			yield(get_tree().create_timer(10), "timeout")
		else:
			yield(get_tree().create_timer(30), "timeout")
			hasntAttacked = true
	elif phase == 3:
		if hasntAttacked:
			hasntAttacked = false
			yield(get_tree().create_timer(4), "timeout")
			playingAllowed = false
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActR-L")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesL-R")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			playingAllowed = true
			yield(get_tree().create_timer(10), "timeout")
		else:
			yield(get_tree().create_timer(30), "timeout")
			hasntAttacked = true
	else:
		pass

func _on_Area_body_entered(body):
	if body is KinematicBody:
		HUD.playerDeath()
#https://godotengine.org/qa/26513/how-check-particular-animation-animationplayer-playing-not
#help with checking current anim

func _on_villainArea_body_entered(body):
	if villainHealth > 0:
		if $"../Player/MovingPlayer/funnyguy/AnimationPlayer".current_animation == "punch":
			if canTakeDamage == true:
				villainHealth = villainHealth - 1
				$"../villainHenchmanGuy/AnimationPlayer".play("bossDamage")
				canTakeDamage = false
				hasntAttacked = true
				phase = phase + 1
				playingAllowed = true
