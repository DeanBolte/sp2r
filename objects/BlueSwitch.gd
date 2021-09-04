extends StaticBody2D

export var inverted = false

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpritePressed").visible = (Console.blueButtonActivated && !inverted) || (!Console.blueButtonActivated && inverted)
	
	# else draw depressed
	get_node("SpriteDepressed").visible = (!Console.blueButtonActivated && !inverted) || (Console.blueButtonActivated && inverted)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2DButton").disabled = (Console.blueButtonActivated && !inverted) || (!Console.blueButtonActivated && inverted)

func _on_ActivationArea_body_entered(body):
	Console.blueButtonActivated = !inverted
