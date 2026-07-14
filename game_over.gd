extends State

@export var gameover_sfx : AudioStreamPlayer2D
@export var crunch_sfx : AudioStreamPlayer2D

@export_category("Cabinet")
@export var cab_screen: AnimatedSprite2D
@export var crunch_fx: CPUParticles2D
@export var swipe_anim: AnimatedSprite2D

func enter() -> void:
	state_machine.set_textbox("IT HAS YOU")
	gameover_sfx.play()
	swipe_anim.play("default")
	state_machine.controlled_node.player.queue_free()
	
func _on_swipe_animation_finished() -> void:
	cab_screen.animation = "it_has_you_1"
	await get_tree().create_timer(2).timeout
	cab_screen.animation = "it_has_you_2"
	crunch_fx.emitting = true
	crunch_sfx.play()
	await get_tree().create_timer(2).timeout
	cab_screen.animation = "it_has_you_3"
	await get_tree().create_timer(2).timeout
	cab_screen.play("leaving")
	state_machine.set_textbox("Final Score: " + str(state_machine.controlled_node.score))
	
func _on_cab_screen_animation_finished() -> void:
	if cab_screen.animation == "leaving":
		get_tree().quit()
