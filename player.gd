extends CharacterBody2D

@export_category("Variables")
@export var speed : float
var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed 
	if direction.x == 0 and direction.y == 0:
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("walking")
	move_and_slide()
