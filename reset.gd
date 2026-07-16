extends State


@export_category("State Nodes")
@export var turn_active : State
@export var fail : State

@export_category("Cabinet")
@export var cab_screen: AnimatedSprite2D
@export var cab_shader: ColorRect

var cab_shader_material: ShaderMaterial

@export var static_sfx: AudioStreamPlayer
## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	cab_shader_material = cab_shader.material
	state_machine.controlled_node.score = 0
	turn_active.sequence_size = 1
	turn_active.turn_length = 5.0
	turn_active.pointer = 0
	fail.distance = 6
	cab_screen.animation = "distance_6"
	cab_shader_material.set_shader_parameter("static_noise", 0.11)
	static_sfx.volume_db = -5.0
	state_machine.set_textbox("")
	state_machine.controlled_node.player.global_position.x = 157.0
	state_machine.controlled_node.player.global_position.y = 432.0
	state_machine.controlled_node.player.show()
	transition_to("turn_active")
## To be implemented by the inheriting node. Called when the state is exited.
func exit() -> void:
	pass


## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	pass


## To be implemented by the inheriting node. Called with _physics_process
func physics_update(_delta: float) -> void:
	pass
