extends Node2D

var buttons : Array
var sequence : Array
var pointer : int
var length : int 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pointer = 0
	length = 1
	$NorthButton.button_pressed.connect(_on_button_pressed)
	$SouthButton.button_pressed.connect(_on_button_pressed)
	$EastButton.button_pressed.connect(_on_button_pressed)
	$WestButton.button_pressed.connect(_on_button_pressed)
	buttons = [$NorthButton, $SouthButton, $WestButton, $EastButton]
	$Label.text = ""
	new_sequence(length)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_sequence(count):
	sequence.resize(count)
	for entry in range(count):
		sequence[entry] = buttons.pick_random()
		
	print(sequence)
	print_escape(count)
	#$Label.text = "PRESS " + str(sequence)

func _on_button_pressed(pressed_button):
#	if pressed_button == sequence:
		#$Label.text = "SAFE"
		#await get_tree().create_timer(1).timeout
		#new_sequence()
	#else:
	#	$Label.text = "HE IS COMING"
	#	await get_tree().create_timer(1).timeout
	#	new_sequence()
	#print("pressed successfully " + str(pressed_button))
	if sequence[pointer] == pressed_button:
		print("safe")
		pointer += 1
		if pointer >= sequence.size():
			print("SAFE")
			$Label.text = "SAFE"
			await get_tree().create_timer(1.5).timeout
			$Label.text = ""
			pointer = 0
			length += 1
			new_sequence(length)
	else:
		print("HE IS COMING")
		$Label.text = "HE IS COMING"
		await get_tree().create_timer(1.5).timeout
		$Label.text = ""
		pointer = 0
		length += 1
		new_sequence(length)
	#if pressed_button == $NorthButton:
		#print("north pressed") 
	#if pressed_button == $SouthButton:
		#print("south pressed")
	#if pressed_button == $EastButton:
		#print("east pressed")
	#if pressed_button == $WestButton:
		#print("west pressed")
func print_escape(count):
	for entry in range(count):
		if sequence[entry] == $NorthButton:
			$Label.text += "NORTH "
		if sequence[entry] == $EastButton:
			$Label.text += "EAST "
		if sequence[entry] == $WestButton:
			$Label.text += "WEST "
		if sequence[entry] == $SouthButton:
			$Label.text += "SOUTH "
	await get_tree().create_timer(2).timeout
	$Label.text = ""	
