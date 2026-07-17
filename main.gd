extends Node2D

@export var player: CharacterBody2D

@export_category("Buttons")
@export var up_button: Area2D
@export var down_button: Area2D
@export var left_button: Area2D
@export var right_button: Area2D

var buttons: Array[Area2D]

@export_category("UI Nodes")
@export var command_text_box: Label

@export_category("Loop States")
@export var loop_1 : State
@export var loop_2 : State

var score    : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttons = [up_button, down_button, left_button, right_button]
	for button in buttons:
		button.button_pressed.connect(loop_1._on_button_pressed)
		
func switch_to_loop_1():
	for button in buttons:
		button.button_pressed.disconnect(loop_2._on_button_pressed)
		button.button_pressed.connect(loop_1._on_button_pressed)
		
func switch_to_loop_2():
	for button in buttons:
		button.button_pressed.disconnect(loop_1._on_button_pressed)
		button.button_pressed.connect(loop_2._on_button_pressed)
