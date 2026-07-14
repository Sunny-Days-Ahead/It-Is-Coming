extends Area2D

signal button_pressed

func _on_body_entered(_body: Node2D) -> void:
	$AnimatedSprite2D.play("pressed")
	button_pressed.emit(self)
	
func _on_body_exited(_body: Node2D) -> void:
	$AnimatedSprite2D.play("default")
