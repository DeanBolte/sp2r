extends StaticBody2D

export var index = 1

func _ready():
	if Console.secretsActivated[index] == false:
		visible = false

func secretGot():
	Console.secretsActivated[index] = true
	visible = true

func is_obtained():
	return Console.secretsActivated[index]
