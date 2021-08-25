extends KinematicBody2D

export var ACCELERATION = 2048
export var MAX_VELCOTITY = 768
export var FRICTION = 0.5
export var AIR_FRICTION = 0.05
export var GRAVITY = 1700
export var JUMP_STRENGTH = 750
export var WALL_JUMP_STRENGTH = 500
export var MAX_JUMPS = 2

var velocity = Vector2.ZERO
var jumps = MAX_JUMPS

func _ready():
	randomize()

func _physics_process(delta):
	# get horizontal inputs
	var move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# movement calculations
	if(move != 0):
		velocity.x += move * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_VELCOTITY, MAX_VELCOTITY)
	
	if(Input.get_action_strength("ui_down")):
		SceneChanger.change_scene("res://world1_secret.tscn", "fade")
	
	# air
	if(is_on_floor()):
		# reset jumps
		jumps = MAX_JUMPS
		
		if(move == 0):
			velocity.x = lerp(velocity.x, 0, FRICTION)
		
		if(Input.is_action_just_pressed("ui_up")):
			velocity.y = -JUMP_STRENGTH
			jumps -= 1
	else:
		# wall jump
		if(is_on_wall()):
			if(Input.is_action_just_pressed("ui_up")):
				velocity.y = -WALL_JUMP_STRENGTH
				velocity.x += WALL_JUMP_STRENGTH * -move
		else:
			# double jump
			if(Input.is_action_just_pressed("ui_up") && jumps > 0):
				velocity.y = -JUMP_STRENGTH
				jumps -= 1
		
		if(Input.is_action_just_released("ui_up") and velocity.y < -JUMP_STRENGTH/2):
			velocity.y = -JUMP_STRENGTH/2
		
		if(move == 0):
			velocity.x = lerp(velocity.x, 0, AIR_FRICTION)
	
	# apply gravity
	velocity.y += GRAVITY * delta
	
	# move character
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_RoomDetector_area_entered(area):
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var view_size = get_viewport_rect().size
	if(size.y < view_size.y):
		size.y = view_size.y
	
	if(size.x < view_size.x):
		size.x = view_size.x
	
	var camera = $Camera2D
	camera.limit_top = collision_shape.global_position.y - size.y/2
	camera.limit_left = collision_shape.global_position.x - size.x/2
	
	camera.limit_bottom = camera.limit_top + size.y
	camera.limit_right = camera.limit_left + size.x

func _on_TransitionDetector_area_entered(area):
	match area.name:
		"World1Secret":
			SceneChanger.change_scene("res://world1_secret.tscn", "fade")
		"World1Trans":
			SceneChanger.change_scene("res://world1_secret.tscn", "fade")
