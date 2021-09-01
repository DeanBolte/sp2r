extends CanvasLayer

onready var AnimationPlayer = $Control/AnimationPlayer
var scene : String

func change_scene(new_scene, anim):
	scene = new_scene
	AnimationPlayer.play(anim)

func _new_scene():
	get_tree().change_scene(scene)
