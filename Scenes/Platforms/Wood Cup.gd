extends StaticBody2D

@onready var cupAnimation: AnimationPlayer = $CupAnimation

func CupVanish() -> void:
	cupAnimation.play("vanish")

func _on_cup_animation_animation_finished(anim_name: StringName) -> void:
	SignalManager.on_cup_destroyed.emit()
	queue_free()
