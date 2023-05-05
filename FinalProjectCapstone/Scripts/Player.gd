extends KinematicBody

export var speed = 14

export var fall_acceleration = 75

export var jump = 12

export var gravity = 50

export var movementAllowed = true

onready var anim = $funnyguy/AnimationPlayer

onready var hurtbox = $CollisionShape

onready var doubleJumpEnable = RuntimeGameData.runTimeData.doubleJumpEnable

onready var rollEnable = RuntimeGameData.runTimeData.rollEnable

onready var audioCheckpoint = preload("res://Sounds/VoiceClips/player_checkpoint.ogg")
onready var audioJump = preload("res://Sounds/VoiceClips/player_jump.ogg")
onready var audioPunch = preload("res://Sounds/VoiceClips/player_punch.ogg")
onready var audioWooHoo = preload("res://Sounds/VoiceClips/player_woohoo.ogg")

#https://docs.godotengine.org/en/stable/classes/class_randomnumbergenerator.html
#RNG for voice clips
var rngVoice = RandomNumberGenerator.new()

var velocity = Vector3.ZERO

var snap = Vector3.DOWN
var last = Vector3.ZERO
var doubleJump = true

export var speedBoost = 1

#https://youtu.be/UpF7wm0186Q This video helped me get started

onready var springarm: Spatial = $Spatial/InterpolatedCamera
onready var model: Spatial = $funnyguy

func _ready():
	anim.get_animation("walking").set_loop(true)
	anim.get_animation("idle").set_loop(true)
	anim.get_animation("jumping").set_loop(false)
	anim.get_animation("inair").set_loop(true)
	anim.get_animation("land").set_loop(false)
	anim.get_animation("roll").set_loop(false)
	anim.get_animation("punch").set_loop(false)

func _physics_process(delta):
	doubleJumpEnable = RuntimeGameData.runTimeData.doubleJumpEnable
	rollEnable = RuntimeGameData.runTimeData.rollEnable
	if movementAllowed == true:
		var direction = Vector3.ZERO
		
		
		
		var landed = is_on_floor() and snap == Vector3.ZERO
		
		var jumping = is_on_floor() and Input.is_action_just_pressed("jump")
		var secondJump = not is_on_floor() and Input.is_action_just_pressed("jump")
		
		var action = Input.is_action_just_pressed("action")
		
		var look_direction = Vector2(last.z, last.x)
		
		direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		direction.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		
		direction = direction.rotated(Vector3.UP, springarm.rotation.y).normalized()
		if anim.current_animation == "roll":
			speedBoost = 2
			jump = 16
			hurtbox.scale = Vector3(0.253,0.1265,0.253)
		else:
			speedBoost = 1
			jump = 12
			hurtbox.scale = Vector3(0.253,0.253,0.253)

		velocity.x = (direction.x * speed * speedBoost)/2
		velocity.z = (direction.z * speed * speedBoost)/2
		velocity.y -= gravity * delta
		
#		if velocity.x >= 14 or velocity.x <= -14:
#			if velocity.x >= 14:
#				velocity.x = 14
#			elif velocity.x <= 14:
#				velocity.x = -14
#		if velocity.z >= 14 or velocity.z <= -14:
#			if velocity.z >= 14:
#				velocity.z = 14
#			elif velocity.z <= 14:
#				velocity.z = -14
				
		
		if jumping:
			velocity.y = jump
			velocity.x = last.x
			velocity.z = last.z
			snap = Vector3.ZERO
			anim.play("jumping")
			if rngVoice.randi_range(0,1) == 1:
				$AudioStreamPlayer.stream = audioJump
				$AudioStreamPlayer.stream.loop = false
				$AudioStreamPlayer.play()
		elif secondJump:
			if doubleJumpEnable == true:
				if doubleJump == true:
					velocity.y = jump
					velocity.x = last.x
					velocity.z = last.z
					anim.play("jumping")
					doubleJump = false
		if landed:
			anim.play("land")
			doubleJump = true
			snap = Vector3.DOWN
			
		if snap == Vector3.DOWN:
			if anim.current_animation == "land" or anim.current_animation == "punch":
				pass
			else:
				if velocity.x == 0 and velocity.z == 0:
					anim.play("idle")
				else:
					if anim.current_animation == "roll":
						pass
					else:
						anim.play("walking")
		elif snap == Vector3.ZERO:
			if anim.current_animation == "jumping" or anim.current_animation == "punch":
				pass
			else:
				anim.play("inair")
		
		velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true)
		
		if action:
			if Vector2(velocity.x, velocity.z).length() > 0.2 && rollEnable:
				anim.play("roll")
			else:
				anim.play("punch")
		
		if Vector2(velocity.x, velocity.z).length() > 0.2:
			last.z = velocity.z
			last.x = velocity.x
			look_direction = Vector2(last.z, last.x)
			model.rotation.y = direction.rotated(Vector3.UP, springarm.rotation.y).normalized().y + 180
			model.rotation.y = look_direction.angle()
			
			
	else:
		anim.play("idle")

#func _process(delta):
	#springarm.translation = translation
