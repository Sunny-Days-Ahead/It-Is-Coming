extends Node2D

var buttons : Array
var sequence : Array
var pointer : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pointer = 0
	$NorthButton.button_pressed.connect(_on_button_pressed)
	$SouthButton.button_pressed.connect(_on_button_pressed)
	$EastButton.button_pressed.connect(_on_button_pressed)
	$WestButton.button_pressed.connect(_on_button_pressed)
	buttons = [$NorthButton, $SouthButton, $WestButton, $EastButton]
	new_sequence()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_sequence():
	sequence = [buttons.pick_random(), buttons.pick_random(), buttons.pick_random(), buttons.pick_random()]
	print(sequence)
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
		print("succ")
		pointer += 1
		if pointer >= sequence.size():
			print("yayy")
			pointer = 0
			new_sequence()
			print(sequence)
	else:
		print("HE IS COMING")
		pointer = 0
	if pressed_button == $NorthButton:
		print("north pressed") 
	if pressed_button == $SouthButton:
		print("south pressed")
	if pressed_button == $EastButton:
		print("east pressed")
	if pressed_button == $WestButton:
		print("west pressed")
