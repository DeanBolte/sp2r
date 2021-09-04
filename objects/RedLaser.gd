extends StaticBody2D

export var inverted = false

func _physics_process(delta):
	visible = (Console.redLasersActivated && !inverted) || (!Console.redLasersActivated && inverted)
	get_node("KillZone").monitorable = (Console.redLasersActivated && !inverted) || (!Console.redLasersActivated && inverted)
