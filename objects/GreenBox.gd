extends StaticBody2D

export var INVERTED = false

func _physics_process(delta):
	# if activated draw pressed
	get_node("SpriteActive").visible = (Console.greenBoxActivated && !INVERTED) || (!Console.greenBoxActivated && INVERTED)
	
	# else draw depressed
	get_node("SpriteInactive").visible = (!Console.greenBoxActivated && !INVERTED) || (Console.greenBoxActivated && INVERTED)
	
	# enable or disable button collision based on activated
	get_node("CollisionShape2D").disabled = (!Console.greenBoxActivated && !INVERTED) || (Console.greenBoxActivated && INVERTED)
