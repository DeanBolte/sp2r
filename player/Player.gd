extends KinematicBody2D

export var ACCELERATION = 2048
export var MAX_VELCOTITY = 768
export var FRICTION = 0.5
export var AIR_FRICTION = 0.05
export var GRAVITY = 1700
export var JUMP_STRENGTH = 750
export var WALL_JUMP_STRENGTH = 500
export var MINIMUM_WALL_VELOCITY = 100
export var MAX_JUMPS = 1
export var MAX_HEALTH = 1

var velocity = Vector2.ZERO
var jumps = MAX_JUMPS
var hp = MAX_HEALTH
var currentWorld = "World1"
var currentArea : Area2D
var entryPosition : Vector2
var entryVelocity : Vector2

func _ready():
	randomize()

func _physics_process(delta):
	if Input.get_action_strength("ui_down"):
		hp = 0
	
	# check player health
	if hp <= 0:
		respawn()
	
	# player movement
	move_state(delta)
	
	move()

func move_state(delta):
	# get horizontal inputs
	var move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# movement calculations
	if move != 0:
		velocity.x += move * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_VELCOTITY, MAX_VELCOTITY)
	
	# air
	if is_on_floor():
		# reset jumps
		jumps = MAX_JUMPS
		
		if move == 0:
			velocity.x = lerp(velocity.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_STRENGTH
	else:
		# wall jump
		if is_on_wall():
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = -WALL_JUMP_STRENGTH
				velocity.x += WALL_JUMP_STRENGTH * -move
			
			# apply gravity
			if velocity.y <= MINIMUM_WALL_VELOCITY:
				velocity.y += GRAVITY * delta
		else:
			# double jump
			if Input.is_action_just_pressed("ui_up") && jumps > 0:
				velocity.y = -JUMP_STRENGTH
				jumps -= 1
			
			# apply gravity
			velocity.y += GRAVITY * delta
		
		if Input.is_action_just_released("ui_up") && velocity.y < -JUMP_STRENGTH/2:
			velocity.y = -JUMP_STRENGTH/2
		
		if move == 0:
			velocity.x = lerp(velocity.x, 0, AIR_FRICTION)

# move character
func move():
	velocity = move_and_slide(velocity, Vector2.UP)

func transition_scene(area_name):
	currentWorld = area_name
	match area_name:
		"World1Secret":
			SceneChanger.change_scene("res://scenes/world1_secret.tscn", "fade")
		"World1":
			SceneChanger.change_scene("res://scenes/world1.tscn", "fade")
		"World2":
			SceneChanger.change_scene("res://scenes/world2.tscn", "fade")
		"World3":
			SceneChanger.change_scene("res://scenes/world2.tscn", "fade")
		"World3Secret":
			SceneChanger.change_scene("res://scenes/world2.tscn", "fade")
		"World4":
			SceneChanger.change_scene("res://scenes/world2.tscn", "fade")
		"World1SecretTrans":
			SceneChanger.secretGot()
			SceneChanger.change_scene("res://scenes/world1.tscn", "fade")
		"World3SecretTrans":
			SceneChanger.secretGot()
			SceneChanger.change_scene("res://scenes/world2.tscn", "fade")

func respawn():
	# reload scene state
	var enemyYsort = currentArea.get_parent().find_node("Enemies")
	if enemyYsort:
		var enemies = enemyYsort.get_children()
		for enemy in enemies:
			enemy.reset()
	
	# reset position and velocity
	position = entryPosition
	velocity = entryVelocity
	
	# reset hp
	hp = MAX_HEALTH

func enemy_hit():
	velocity.y = -JUMP_STRENGTH

func _on_RoomDetector_area_entered(area):
	# save current area
	if area != currentArea:
		currentArea = area
		entryPosition = position
		entryVelocity = velocity
	
	# handle camera movement
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var view_size = get_viewport_rect().size
	if size.y < view_size.y:
		size.y = view_size.y
	
	if size.x < view_size.x:
		size.x = view_size.x
	
	var camera = $Camera2D
	camera.limit_top = collision_shape.global_position.y - size.y/2
	camera.limit_left = collision_shape.global_position.x - size.x/2
	
	camera.limit_bottom = camera.limit_top + size.y
	camera.limit_right = camera.limit_left + size.x

func _on_TransitionDetector_area_entered(area):
	transition_scene(area.name)

func _on_HitBox_area_entered(_area):
	hp = 0

func _on_SecretDetector_area_entered(area):
	var secret = area.get_parent()
	if secret.is_obtained() == false:
		secret.secretGot()
		SceneChanger.secretGot()
