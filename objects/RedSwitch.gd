extends StaticBody2D

export var INVERTED = false

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpritePressed").visible = (!Console.redLasersActivated && !INVERTED) || (Console.redLasersActivated && INVERTED)
	
	# else draw depressed
	get_node("SpriteDepressed").visible = (Console.redLasersActivated && !INVERTED) || (!Console.redLasersActivated && INVERTED)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2DButton").disabled = (!Console.redLasersActivated && !INVERTED) || (Console.redLasersActivated && INVERTED)

func _on_ActivationArea_body_entered(body):
	Console.redLasersActivated = INVERTED
