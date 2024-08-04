extends Area2D

@onready var waterPlayer: AudioStreamPlayer2D = $WaterPlayer

const GP_NAME = "animal"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(GP_NAME):
		waterPlayer.play()
