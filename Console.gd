extends CanvasLayer

export var NUMBER_OF_SECRETS = 18

var secretsActivated = []

func _ready():
	for i in range(NUMBER_OF_SECRETS):
		secretsActivated.append(false)
