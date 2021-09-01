extends StaticBody2D

export var number = 1

func _ready():
	if Console.secretsActivated[number] == false:
		visible = false

func secretGot():
	Console.secretsActivated[number] = true
	visible = true
