extends StaticBody2D

export var INVERTED = false

var currentArea

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpritePressed").visible = (!Console.greenBoxActivated && !INVERTED) || (Console.greenBoxActivated && INVERTED)
	
	# else draw depressed
	get_node("SpriteDepressed").visible = (Console.greenBoxActivated && !INVERTED) || (!Console.greenBoxActivated && INVERTED)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2DButton").disabled = (!Console.greenBoxActivated && !INVERTED) || (Console.greenBoxActivated && INVERTED)

func _on_ActivationArea_body_entered(body):
	if Console.activeArea == currentArea:
		Console.greenBoxActivated = INVERTED

func _on_RoomDetector_area_entered(area):
	currentArea = area
