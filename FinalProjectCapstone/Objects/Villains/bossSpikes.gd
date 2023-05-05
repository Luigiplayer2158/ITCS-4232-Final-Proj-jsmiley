extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var HUD = $"../HUD"

onready var djNotif = $"../HUD/doubleJumpNotif"

onready var player = $"../Player"

onready var villain = $"../villainHenchmanGuy"
onready var longPlat = $"../LongPlatformObject4"
onready var endObj = $"../level_end"

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
	endObj.portalAllowed = false
	$"../smallPlat3".visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if villainHealth == 0:
		if doOnce == true:
			$"../villainHenchmanGuy/AnimationPlayer".play("bossDefeat")
			doOnce = false
			endObj.portalAllowed = true
			$"../smallPlat3".visible = true
			playingAllowed = false
			RuntimeGameData.runTimeData.doubleJumpEnable = true
			RuntimeGameData.runTimeData.rollEnable = true
			djNotif.visible = true
			yield(get_tree().create_timer(8), "timeout")
			djNotif.visible = false
			
	
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
			longPlat.global_transform.origin = Vector3(0.00,-13.00,-10)
			yield(get_tree().create_timer(4), "timeout")
			playingAllowed = false
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActR-L")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesL-R")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(3), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			playingAllowed = true
			longPlat.global_transform.origin = Vector3(0.00,-0.953,6.5)
	elif phase == 2:
		if hasntAttacked:
			hasntAttacked = false
			longPlat.global_transform.origin = Vector3(0.00,-13.00,-10)
			yield(get_tree().create_timer(4), "timeout")
			playingAllowed = false
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActR-L")
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play("bossSpikesL-R")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			playingAllowed = true
			longPlat.global_transform.origin = Vector3(0.00,-0.953,6.5)
	elif phase == 3:
		if hasntAttacked:
			hasntAttacked = false
			longPlat.global_transform.origin = Vector3(0.00,-13.00,-10.00)
			yield(get_tree().create_timer(4), "timeout")
			playingAllowed = false
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActR-L")
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play("bossSpikesL-R")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActL-R")
			yield(get_tree().create_timer(2), "timeout")
			$AnimationPlayer.play("bossSpikesR-L")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(2), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossActForward")
			yield(get_tree().create_timer(3), "timeout")
			$AnimationPlayer.play("bossSpikesForward")
			$"../villainHenchmanGuy/AnimationPlayer".stop()
			yield(get_tree().create_timer(1), "timeout")
			$"../villainHenchmanGuy/AnimationPlayer".play("bossStun")
			$"../bossSpikes/AnimationPlayer".play("autohide")
			longPlat.global_transform.origin = Vector3(0.00,-0.953,6.5)
	else:
		pass

func _on_Area_body_entered(body):
	if body is KinematicBody:
		if body.name == "MovingPlayer":
			HUD.playerDeath()
#https://godotengine.org/qa/26513/how-check-particular-animation-animationplayer-playing-not
#help with checking current anim

func _on_villainArea_body_entered(body):
	if villainHealth > 0:
		if $"../Player/MovingPlayer/funnyguy/AnimationPlayer".current_animation == "punch" || $"../Player/MovingPlayer/funnyguy/AnimationPlayer".current_animation == "roll" :
			if canTakeDamage == true:
				villainHealth = villainHealth - 1
				$"../villainHenchmanGuy/AnimationPlayer".play("bossDamage")
				canTakeDamage = false
				hasntAttacked = true
				phase = phase + 1
				playingAllowed = true
