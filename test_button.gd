extends Area2D

signal button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("pressed")
	button_pressed.emit(self)
	
func _on_body_exited(body: Node2D) -> void:
	$AnimatedSprite2D.play("default")
