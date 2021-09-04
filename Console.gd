extends CanvasLayer

export var NUMBER_OF_SECRETS = 18

var secretsActivated = []
var redLasersActivated = true

func _ready():
	for i in range(NUMBER_OF_SECRETS):
		secretsActivated.append(false)

func secretGot(index):
	secretsActivated[index] = true

func resetLasers():
	redLasersActivated = true
