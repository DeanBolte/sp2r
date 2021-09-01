extends CanvasLayer

export var NUMBER_OF_SECRETS = 18

var secretsActivated = []

func secretGot(index):
	secretsActivated[index] = true

func _ready():
	for i in range(NUMBER_OF_SECRETS):
		secretsActivated.append(false)
