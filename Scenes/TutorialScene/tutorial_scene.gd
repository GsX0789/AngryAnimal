extends Control

@onready var tb_main_scene: TextureButton = $TB_MainScene
const SCALE_VALUE = Vector2(1.1,1.1)
const DEFAULT_SCALE = Vector2(1.0,1.0)

func _on_tb_main_scene_mouse_entered() -> void:
	tb_main_scene.scale = SCALE_VALUE


func _on_tb_main_scene_mouse_exited() -> void:
	tb_main_scene.scale = DEFAULT_SCALE


func _on_tb_main_scene_pressed() -> void:
	SceneManager.LoadMainScene()
