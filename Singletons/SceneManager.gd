extends Node

var main_scene : PackedScene = preload("res://Scenes/Levels/main_scene.tscn")
var tutorial_scene : PackedScene = preload("res://Scenes/TutorialScene/tutorial_scene.tscn")

func LoadMainScene() -> void:
	get_tree().change_scene_to_packed(main_scene)
	
func LoadTutorialScene() -> void:
	get_tree().change_scene_to_packed(tutorial_scene)
