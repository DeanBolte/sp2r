extends KinematicBody2D

export var MOVE_SPEED = 250
export var GRAVITY = 1700
export var JUMP_STRENGTH = 550
export var MINIMUM_JUMP_HEIGHT = 48
export var JUMP_DISTANCE_MODIFIER = 3 # divides the distance between the collision object

var velocity = Vector2.ZERO
var dir = 1

func _physics_process(delta):
	if is_on_floor():
		# check for possible jump
		var testVel = velocity
		testVel.x /= JUMP_DISTANCE_MODIFIER
		if test_move(transform, testVel):
			var jumpVelocity = testVel
			jumpVelocity.y = -MINIMUM_JUMP_HEIGHT
			if !test_move(transform, jumpVelocity):
				velocity.y = -JUMP_STRENGTH
	
	# change directions at wall
	if is_on_wall():
		dir *= -1
	else:
		velocity.x = MOVE_SPEED * dir
	
	
	# apply gravity
	velocity.y += GRAVITY * delta
	
	# move character
	velocity = move_and_slide(velocity, Vector2.UP)
