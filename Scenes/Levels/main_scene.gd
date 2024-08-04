extends Control

@onready var tb_tutorial: TextureButton = $TB_Tutorial
const SCALE_VALUE = Vector2(1.1,1.1)
const DEFAULT_SCALE = Vector2(1.0,1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exitgame"):
		get_tree().quit()


func _on_tb_tutorial_mouse_entered() -> void:
	tb_tutorial.scale = SCALE_VALUE


func _on_tb_tutorial_mouse_exited() -> void:
	tb_tutorial.scale = DEFAULT_SCALE


func _on_tb_tutorial_pressed() -> void:
	SceneManager.LoadTutorialScene()
	
