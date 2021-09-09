extends CanvasLayer

export var NUMBER_OF_SECRETS = 18

var secretsActivated = []
var redLasersActivated = true
var blueButtonActivated = false
var greenBoxActivated = true
var yellowBoxActivated = false

var activeArea : Area2D

func _ready():
	for i in range(NUMBER_OF_SECRETS):
		secretsActivated.append(false)

func secretGot(index):
	secretsActivated[index] = true

func resetLasers():
	redLasersActivated = true

func resetBlueButton():
	blueButtonActivated = false

func resetGreenBox():
	greenBoxActivated = true

func resetYellowBox():
	yellowBoxActivated = false
