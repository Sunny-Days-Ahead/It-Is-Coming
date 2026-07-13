extends Node2D

var buttons  : Array
var sequence : Array

var pointer  : int
var length   : int 
var distance : int

var score    : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pointer = 0
	length = 1
	distance = 5
	
	$NorthButton.button_pressed.connect(_on_button_pressed)
	$SouthButton.button_pressed.connect(_on_button_pressed)
	$EastButton.button_pressed.connect(_on_button_pressed)
	$WestButton.button_pressed.connect(_on_button_pressed)
	buttons = [$NorthButton, $SouthButton, $WestButton, $EastButton]
	$Command.text = ""
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

func _on_button_pressed(pressed_button):
	if pointer >= sequence.size():
		return
		
	if sequence[pointer] == pressed_button:
		pointer += 1
		if pointer >= sequence.size():
			print("SAFE")
			$Command.text = "SAFE"
			await get_tree().create_timer(1.5).timeout
			$Command.text = ""
			pointer = 0
			increase_length()
			new_sequence(length)
	else:
		pointer = 0
		increase_length()
		it_is_coming()
		
	#if pressed_button == $NorthButton:
		#print("north pressed") 
	#if pressed_button == $SouthButton:
		#print("south pressed")
	#if pressed_button == $EastButton:
		#print("east pressed")
	#if pressed_button == $WestButton:
		#print("west pressed")
		
func gameover():
	$Command.text = "IT HAS YOU"
	$Swipe.play("default")
	$Player.queue_free()
	
	await get_tree().create_timer(15).timeout
	get_tree().quit()
	
func print_escape(count):
	for entry in range(count):
		if sequence[entry] == $NorthButton:
			$Command.text += "^ "
		if sequence[entry] == $EastButton:
			$Command.text += "> "
		if sequence[entry] == $WestButton:
			$Command.text += "< "
		if sequence[entry] == $SouthButton:
			$Command.text += "v "
	await get_tree().create_timer(2).timeout
	$Command.text = ""	

func increase_length():
	length += 1
	if length > 5:
		length = 5
	else:
		pass 
func it_is_coming():
	print("IT IS COMING")
	$Command.text = "IT IS COMING"
	await get_tree().create_timer(1.5).timeout
	$Command.text = ""
	distance -= 1 
	match distance: 
		5:
			$CabScreen.animation = "distance_5"
		4:
			$CabScreen.animation = "distance_4"
		3:
			$CabScreen.animation = "distance_3"
		2:
			$CabScreen.animation = "distance_2"
		1:
			$CabScreen.animation = "distance_1"
	print("distance left " + str(distance))
	if distance <= 0:
		gameover()
	else: 
		new_sequence(length)
