extends KinematicBody2D

export var ACCELERATION = 2048
export var MAX_VELCOTITY = 768
export var FRICTION = 0.5
export var AIR_FRICTION = 0.05
export var GRAVITY = 1700
export var JUMP_STRENGTH = 750
export var WALL_JUMP_STRENGTH = 500

var velocity = Vector2.ZERO

func _ready():
	randomize()

func _physics_process(delta):
	# get horizontal inputs
	var move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# movement calculations
	if(move != 0):
		velocity.x += move * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_VELCOTITY, MAX_VELCOTITY)
	
	# air
	if(is_on_floor()):
		if(move == 0):
			velocity.x = lerp(velocity.x, 0, FRICTION)
		
		if(Input.is_action_just_pressed("ui_up")):
			velocity.y = -JUMP_STRENGTH
	else:
		# wall jump
		if(is_on_wall()):
			if(Input.is_action_just_pressed("ui_up")):
				velocity.y = -WALL_JUMP_STRENGTH
				velocity.x += WALL_JUMP_STRENGTH * -move
		
		if(Input.is_action_just_released("ui_up") and velocity.y < -JUMP_STRENGTH/2):
			velocity.y = -JUMP_STRENGTH/2
		
		if(move == 0):
			velocity.x = lerp(velocity.x, 0, AIR_FRICTION)
	
	# apply gravity
	velocity.y += GRAVITY * delta
	
	# move character
	velocity = move_and_slide(velocity, Vector2.UP)
