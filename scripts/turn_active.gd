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

func enter() -> void:
	new_sequence()
	print_escape()
	display_timeout.start()
	time_left.wait_time = turn_length
	time_left.start()

func exit() -> void:
	time_left.stop()
	display_timeout.stop()
	
	sequence_size += 1
	if sequence_size > 5:
		sequence_size = 5
		
	pointer = 0

## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	time_bar.max_value = turn_length
	time_bar.value = time_left.time_left


func _on_time_left_timeout() -> void:
	transition_to("fail")

func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")

func _on_button_pressed(pressed_button):
	button_sound.play()
	if sequence[pointer] == pressed_button:
		pointer += 1
	else:
		transition_to("fail")
		
	if pointer >= sequence.size():
		transition_to("success")
		

func new_sequence():
	sequence.resize(sequence_size)
	for entry in range(sequence_size):
		sequence[entry] = state_machine.controlled_node.buttons.pick_random()
	if sequence_size == 5:
		turn_length = 6.0
	
func print_escape():
	for entry in range(sequence.size()):
		if sequence[entry] == state_machine.controlled_node.up_button:
			state_machine.append_textbox("^ ")
		if sequence[entry] == state_machine.controlled_node.right_button:
			state_machine.append_textbox("> ")
		if sequence[entry] == state_machine.controlled_node.left_button:
			state_machine.append_textbox("< ")
		if sequence[entry] == state_machine.controlled_node.down_button:
			state_machine.append_textbox("v ")
