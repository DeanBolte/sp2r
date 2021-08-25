extends KinematicBody2D

export var MOVE_SPEED = 200
export var GRAVITY = 1700

var velocity = Vector2.ZERO
var dir = 1

func _physics_process(delta):
	if is_on_wall():
		dir *= -1
	else:
		velocity.x = MOVE_SPEED * dir
	
	# apply gravity
	velocity.y += GRAVITY * delta
	
	# move character
	velocity = move_and_slide(velocity, Vector2.UP)
