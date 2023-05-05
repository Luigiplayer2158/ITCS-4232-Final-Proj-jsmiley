extends Spatial


# https://docs.godotengine.org/en/stable/classes/class_timer.html
# https://godotengine.org/qa/7042/wait-like-function
# https://docs.godotengine.org/en/stable/classes/class_scenetree.html#class-scenetree-method-create-timer
# help with making a waiting timer
# godot docs show how to make one, but only in 4.0. the forums helped me convert the new function back to the 3.0 engine

var shrinkBegin = false
export var shrinkSpeed = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shrinkBegin == true:
		if $smallPlat/Cube.scale.y > 0:
			$smallPlat/Cube.scale.y = $smallPlat/Cube.scale.y - shrinkSpeed
			$smallPlat/Area.monitoring = false
		else:
			$smallPlat.visible = false
			$smallPlat/Cube/StaticBody/CollisionShape.disabled = true
			yield(get_tree().create_timer(3), "timeout")
			$smallPlat.visible = true
			$smallPlat/Cube/StaticBody/CollisionShape.disabled = false
			$smallPlat/Cube.scale.y = 1
			shrinkBegin = false
			$smallPlat/Area.monitoring = true


func _on_Area_body_entered(body):
	if body is KinematicBody:
		shrinkBegin = true


func _on_Area_body_exited(body):
	pass
