extends AnimatedSprite2D

var current_frame = self.get_frame()
var current_progress = self.get_frame_progress()
var swipe_hitbox
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swipe_hitbox = $Area2D/CollisionShape2D
	swipe_hitbox.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_frame == 4:
		swipe_hitbox.disabled = false 
	if current_frame == 6:
		swipe_hitbox.disable = true
