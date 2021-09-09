extends StaticBody2D

export var INVERTED = false

var currentArea
var buttonHeld

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpritePressed").visible = (!Console.redLasersActivated && !INVERTED) || (Console.redLasersActivated && INVERTED)
	
	# else draw depressed
	get_node("SpriteDepressed").visible = (Console.redLasersActivated && !INVERTED) || (!Console.redLasersActivated && INVERTED)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2DButton").disabled = (!Console.redLasersActivated && !INVERTED) || (Console.redLasersActivated && INVERTED)
	
	# apply state based on if an object is inside activation area
	if buttonHeld:
		Console.redLasersActivated = INVERTED

func _on_ActivationArea_body_entered(body):
	if Console.activeArea == currentArea:
		buttonHeld = true

func _on_ActivationArea_body_exited(body):
	if Console.activeArea == currentArea:
		buttonHeld = false

func _on_RoomDetector_area_entered(area):
	currentArea = area
