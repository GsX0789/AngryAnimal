extends Node2D

var animalSpawn: PackedScene = preload("res://Scenes/Player/playerAnimal.tscn")

@onready var spawnPoint: Marker2D = $SpawnPoint
@onready var playerHolder: Node = $PlayerHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_animal_death.connect(InstantiateAnimal)
	InstantiateAnimal()

func InstantiateAnimal() -> void:
	var newXPos = spawnPoint.position.x
	var newYPos = spawnPoint.position.y
	var animalInstance = animalSpawn.instantiate()
	animalInstance.position = Vector2(newXPos, newYPos)
	playerHolder.add_child(animalInstance)
	#another way of doing the position is set our animal.global position to the spawnPoint.globalPosition
