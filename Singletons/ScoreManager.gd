extends Node

const DEFAULT_SCORE : int = 1000
const SCORE_PATH = "user://animals.dat"

var levelSelected : int = 1
var levelScores : Dictionary = {}

func _ready() -> void:
	LoadToDisc()
	
func SetLevelSelected(ls : int) -> void:
	levelSelected = ls

func GetLevelSelected() -> int:
	return levelSelected


func CheckAndAdd(level : String) -> void:
	if levelScores.has(level) == false:	
		levelScores[level] = DEFAULT_SCORE

func SetScoreForLevel(score : int, level : String):
	CheckAndAdd(level)
	if levelScores[level] > score:
		levelScores[level] = score
		SaveToDisc()
		
func GetBestForLevel(level : String) -> int:
	CheckAndAdd(level)
	return levelScores[level]
	
	
func SaveToDisc() -> void :
	var file = FileAccess.open(SCORE_PATH, FileAccess.WRITE)
	var scoreJsonStr = JSON.stringify(levelScores)
	file.store_string(scoreJsonStr)
	file.close()
	
func LoadToDisc() -> void:
	var file = FileAccess.open(SCORE_PATH, FileAccess.READ)
	if file == null:
		SaveToDisc()
	else:
		var data = file.get_as_text()
		levelScores = JSON.parse_string(data)
