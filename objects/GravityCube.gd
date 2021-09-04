extends KinematicBody2D

export var GRAVITY = 1000

var velocity = Vector2.ZERO

func _physics_process(delta):
	# get gravity direction
	var direction = -1
	if Console.blueButtonActivated:
		direction = 1
	
	# apply gravity
	velocity.y += GRAVITY * delta * direction
	
	# move cube
	velocity.x = 0
	velocity = move_and_slide(velocity)
