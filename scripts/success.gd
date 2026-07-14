extends State

@export var display_timeout : Timer

## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	state_machine.set_textbox("SAFE")
	display_timeout.start()
	state_machine.increment_score()

## To be implemented by the inheriting node. Called when the state is exited.
func exit() -> void:
	pass

## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	pass

## To be implemented by the inheriting node. Called with _physics_process
func physics_update(_delta: float) -> void:
	pass


func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")
	transition_to("turn_active")
