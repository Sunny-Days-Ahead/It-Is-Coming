extends State

@export_category("Timers")
@export var time_left : Timer 
@export var display_timeout : Timer

@export var time_bar : ProgressBar

@export var button_sound : AudioStreamPlayer2D

var sequence : Array[Area2D]
var sequence_size : int = 1
var turn_length: float = 5.0
var pointer: int = 0
var button_presses : int = 0

func enter() -> void:
	button_presses = 0
	state_machine.controlled_node.call("switch_to_loop_2")

func exit() -> void:
	state_machine.controlled_node.call("switch_to_loop_1")

## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	time_bar.max_value = turn_length
	time_bar.value = time_left.time_left


func _on_time_left_timeout() -> void:
	pass

func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")

func _on_button_pressed(pressed_button):
	button_sound.play()
	button_presses += 1
	if button_presses == 10:
		transition_to("game_over")
		
