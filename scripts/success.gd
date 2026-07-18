extends State

@export var display_timeout : Timer

func enter() -> void:
	state_machine.set_textbox("SAFE... " + str(state_machine.controlled_node.score + 1))
	display_timeout.start()
	state_machine.increment_score()

func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")
	transition_to("turn_active")
