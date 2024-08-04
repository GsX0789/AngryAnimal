extends TextureButton

const HOVER_SCALE : Vector2 = Vector2(1.1,1.1)
const DEFAULT_SCALE : Vector2 = Vector2(1.0,1.0)

@export var levelNumber : int = 1

@onready var levelLabel: Label = $MC/VBoxContainer/LevelLabel
@onready var scoreLabel: Label = $MC/VBoxContainer/ScoreLabel

var levelScene : PackedScene

func _ready() -> void:
	levelLabel.text = str(levelNumber)
	var bestSC = ScoreManager.GetBestForLevel(str(levelNumber))
	scoreLabel.text = str(bestSC)
	levelScene = load("res://Scenes/Levels/level%s.tscn" % levelNumber)


func _on_pressed() -> void:
	ScoreManager.SetLevelSelected(levelNumber)
	get_tree().change_scene_to_packed(levelScene)


func _on_mouse_entered() -> void:
	scale = HOVER_SCALE


func _on_mouse_exited() -> void:
	scale = DEFAULT_SCALE
