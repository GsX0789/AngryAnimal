extends Node

var attempts : int = 0
var cupsHits : int = 0
var totalCups : int = 0
var levelNumber : int = 1

func _ready() -> void:
	totalCups = get_tree().get_nodes_in_group("Cups").size()
	levelNumber = ScoreManager.GetLevelSelected()
	SignalManager.on_attempt_made.connect(IncreaseAttempts)
	SignalManager.on_cup_destroyed.connect(IncreaseCupHit)

func IncreaseAttempts() -> void:
	attempts += 1
	SignalManager.on_score_updated.emit(attempts)
	
func IncreaseCupHit() -> void:
	cupsHits += 1
	if cupsHits == totalCups:
		SignalManager.on_level_complete.emit()
		ScoreManager.SetScoreForLevel(attempts, str(levelNumber))
