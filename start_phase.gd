extends State


## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	state_machine.controlled_node.new_sequence(state_machine.sequence_length)


## To be implemented by the inheriting node. Called when the state is exited.
func exit() -> void:
	pass


## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	pass


## To be implemented by the inheriting node. Called with _physics_process
func physics_update(_delta: float) -> void:
	pass
