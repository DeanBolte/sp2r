extends StaticBody2D

export var INVERTED = false
export var STATIC = false

func _physics_process(delta):
	if !STATIC:
		visible = (Console.redLasersActivated && !INVERTED) || (!Console.redLasersActivated && INVERTED)
		get_node("KillZone").monitorable = (Console.redLasersActivated && !INVERTED) || (!Console.redLasersActivated && INVERTED)
