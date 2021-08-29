extends CanvasLayer

onready var AnimationPlayer = $Control/AnimationPlayer
var scene : String

var secretCount = 0

func secretGot():
	secretCount += 1

func change_scene(new_scene, anim):
	scene = new_scene
	AnimationPlayer.play(anim)

func _new_scene():
	get_tree().change_scene(scene)
