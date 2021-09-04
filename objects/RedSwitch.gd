extends StaticBody2D

export var inverted = false

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpritePressed").visible = (!Console.redLasersActivated && !inverted) || (Console.redLasersActivated && inverted)
	
	# else draw depressed
	get_node("SpriteDepressed").visible = (Console.redLasersActivated && !inverted) || (!Console.redLasersActivated && inverted)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2DButton").disabled = (!Console.redLasersActivated && !inverted) || (Console.redLasersActivated && inverted)

func _on_ActivationArea_body_entered(body):
	Console.redLasersActivated = inverted
