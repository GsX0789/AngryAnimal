extends Control

@onready var attemptsLabel: Label = $MC/VBContainer/AttemptsLabel
@onready var levelLabel: Label = $MC/VBContainer/LevelLabel
@onready var levelCompletedVB: VBoxContainer = $MC/VBContainer2
@onready var gameCompleteSound: AudioStreamPlayer = $GameCompleteSound

const MAINSCENE = preload("res://Scenes/Levels/main_scene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLevelLabel()
	UpdateAttempts(0)
	SignalManager.on_score_updated.connect(UpdateAttempts)
	SignalManager.on_level_complete.connect(LevelCompleted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("completeScene"):
		get_tree().change_scene_to_packed(MAINSCENE)

func UpdateLevelLabel() -> void:
	levelLabel.text = "Level : %s" % ScoreManager.GetLevelSelected()

func UpdateAttempts(attempts: int) -> void:
	attemptsLabel.text = "Attempts: %s " % str(attempts)

func LevelCompleted() -> void:
	if !levelCompletedVB.is_visible_in_tree():
		levelCompletedVB.show()
	gameCompleteSound.play()
