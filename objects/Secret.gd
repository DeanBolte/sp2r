extends StaticBody2D

export var number = 1

func _ready():
	if Console.secrets[number] == false:
		visible = false

func secretGot():
	Console.secrets[number] = true
	visible = true
