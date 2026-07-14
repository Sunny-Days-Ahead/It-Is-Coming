extends State

@export_category("Timers")
@export var time_left : Timer 
@export var display_timeout : Timer

var sequence : Array[Area2D]
var sequence_size : int = 1
var turn_length: float = 5.0
var pointer: int = 0

## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	new_sequence()
	print_escape()
	display_timeout.start()
	time_left.wait_time = turn_length
	time_left.start()

## To be implemented by the inheriting node. Called when the state is exited.
func exit() -> void:
	time_left.stop()
	display_timeout.stop()
	
	sequence_size += 1
	if sequence_size > 5:
		sequence_size = 5
		
	pointer = 0

## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	pass

## To be implemented by the inheriting node. Called with _physics_process
func physics_update(_delta: float) -> void:
	pass


func _on_time_left_timeout() -> void:
	transition_to("fail")

func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")

func _on_button_pressed(pressed_button):
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
