extends KinematicBody

export var speed = 14

export var fall_acceleration = 75

export var jump = 12

export var gravity = 50

onready var anim = $funnyguy/AnimationPlayer

var velocity = Vector3.ZERO

var snap = Vector3.DOWN
var last = Vector3.ZERO

#https://youtu.be/UpF7wm0186Q This video helped me get started

onready var springarm: Spatial = $Spatial/InterpolatedCamera
onready var model: Spatial = $funnyguy

func _ready():
	anim.get_animation("walking").set_loop(true)
	anim.get_animation("idle").set_loop(true)
	anim.get_animation("jumping").set_loop(false)
	anim.get_animation("inair").set_loop(true)
	anim.get_animation("land").set_loop(false)

func _physics_process(delta):
	
		var direction = Vector3.ZERO
		
		
		
		var landed = is_on_floor() and snap == Vector3.ZERO
		
		var jumping = is_on_floor() and Input.is_action_just_pressed("jump")
		
		var look_direction = Vector2(last.z, last.x)
		
		direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		direction.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		
		direction = direction.rotated(Vector3.UP, springarm.rotation.y).normalized()

		velocity.x = (direction.x * speed)/2
		velocity.z = (direction.z * speed)/2
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
		elif landed:
			anim.play("land")
			snap = Vector3.DOWN
			
		if snap == Vector3.DOWN:
			if anim.current_animation == "land":
				pass
			else:
				if velocity.x == 0 and velocity.z == 0:
					anim.play("idle")
				else:
					anim.play("walking")
		elif snap == Vector3.ZERO:
			if anim.current_animation == "jumping":
				pass
			else:
				anim.play("inair")
		
		velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true)
		
		if Vector2(velocity.x, velocity.z).length() > 0.2:
			last.z = velocity.z
			last.x = velocity.x
			look_direction = Vector2(last.z, last.x)
			model.rotation.y = direction.rotated(Vector3.UP, springarm.rotation.y).normalized().y + 180
			model.rotation.y = look_direction.angle()
			
		

#func _process(delta):
	#springarm.translation = translation
