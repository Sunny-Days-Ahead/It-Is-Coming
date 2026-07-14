extends State

@export var display_timeout : Timer
@export var fail_sfx: AudioStreamPlayer2D
@export var step_sfx: AudioStreamPlayer2D
@export_category("Cabinet")
@export var cab_screen: AnimatedSprite2D

var distance: int = 6

var steps_done: bool = false
var timer_done: bool = false

## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	steps_done = false
	timer_done = false
	
	distance -= 1
	
	if distance < 1:
		transition_to("game_over")
		return
	
	state_machine.set_textbox("IT IS COMING")
	fail_sfx.play()
	display_timeout.start()
	
	match distance: 
		6:
			cab_screen.animation = "distance_6"
		5:
			cab_screen.play("distance_5")
		4:
			cab_screen.animation = "distance_4"
		3:
			cab_screen.animation = "distance_3"
		2:
			cab_screen.animation = "distance_2"
		1:
			cab_screen.animation = "distance_1"
	

## To be implemented by the inheriting node. Called when the state is exited.
func exit() -> void:
	pass

## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	if steps_done and timer_done:
		transition_to("turn_active")

## To be implemented by the inheriting node. Called with _physics_process
func physics_update(_delta: float) -> void:
	pass


func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")
	timer_done = true

func _on_it_is_coming_finished() -> void:
	step_sfx.play()

func _on_foot_steps_finished() -> void:
	steps_done = true
