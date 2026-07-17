extends State

@export var display_timeout : Timer
@export var fail_sfx: AudioStreamPlayer2D
@export var step_sfx: AudioStreamPlayer2D
@export var static_sfx: AudioStreamPlayer

@export_category("Cabinet")
@export var cab_screen: AnimatedSprite2D
@export var cab_shader: ColorRect
@export var drool_fx: CPUParticles2D

var cab_shader_material: ShaderMaterial

var distance: int = 6
var steps_done: bool = false
var timer_done: bool = false

func enter() -> void:
	cab_shader_material = cab_shader.material
	
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
			cab_shader_material.set_shader_parameter("static_noise", 0.11)
			static_sfx.volume_db = -5.0
		5:
			cab_screen.play("distance_5")
			cab_shader_material.set_shader_parameter("static_noise", 0.22)
			static_sfx.volume_db = -4.0
		4:
			cab_screen.play("distance_4")
			cab_shader_material.set_shader_parameter("static_noise", 0.33)
			static_sfx.volume_db = -3.0
		3:
			cab_screen.play("distance_3")
			cab_shader_material.set_shader_parameter("static_noise", 0.44)
			static_sfx.volume_db = -2.0
		2:
			cab_screen.play("distance_2")
			cab_shader_material.set_shader_parameter("static_noise", 0.55)
			static_sfx.volume_db = -1.0
		1:
			cab_screen.animation = "distance_1"
			cab_shader_material.set_shader_parameter("static_noise", 0.66)
			static_sfx.volume_db = 0.0
			drool_fx.emitting = true

## To be implemented by the inheriting node. Called with _process
func update(_delta: float) -> void:
	if steps_done and timer_done:
		transition_to("turn_active")
		

func _on_display_timeout_timeout() -> void:
	state_machine.set_textbox("")
	timer_done = true

func _on_it_is_coming_finished() -> void:
	step_sfx.play()

func _on_foot_steps_finished() -> void:
	steps_done = true
