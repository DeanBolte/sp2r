extends StaticBody2D

export var INVERTED = false

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpritePressed").visible = (Console.blueButtonActivated && !INVERTED) || (!Console.blueButtonActivated && INVERTED)
	
	# else draw depressed
	get_node("SpriteDepressed").visible = (!Console.blueButtonActivated && !INVERTED) || (Console.blueButtonActivated && INVERTED)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2DButton").disabled = (Console.blueButtonActivated && !INVERTED) || (!Console.blueButtonActivated && INVERTED)

func _on_ActivationArea_body_entered(body):
	Console.blueButtonActivated = !INVERTED
