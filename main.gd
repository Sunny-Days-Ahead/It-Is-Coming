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
	score = 0
	
	$NorthButton.button_pressed.connect(_on_button_pressed)
	$SouthButton.button_pressed.connect(_on_button_pressed)
	$EastButton.button_pressed.connect(_on_button_pressed)
	$WestButton.button_pressed.connect(_on_button_pressed)
	buttons = [$NorthButton, $SouthButton, $WestButton, $EastButton]
	$CabScreen/Control/Command.text = ""
	new_sequence(length)

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
			$TimeLeft.stop()
			$CabScreen/Control/Command.text = "SAFE"
			await get_tree().create_timer(1.5).timeout
			$CabScreen/Control/Command.text = ""
			pointer = 0
			score += 1
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
	$CabScreen/Control/Command.text = "IT HAS YOU"
	$Audio/ItHasYou.play()
	if is_instance_valid($Player) == true:
		$Swipe.play("default")
		$Player.queue_free()
	
func print_escape(count):
	for entry in range(count):
		if sequence[entry] == $NorthButton:
			$CabScreen/Control/Command.text += "^ "
		if sequence[entry] == $EastButton:
			$CabScreen/Control/Command.text += "> "
		if sequence[entry] == $WestButton:
			$CabScreen/Control/Command.text += "< "
		if sequence[entry] == $SouthButton:
			$CabScreen/Control/Command.text += "v "
	await get_tree().create_timer(2).timeout
	$CabScreen/Control/Command.text = ""	
	$TimeLeft.start(5)

func increase_length():
	length += 1
	if length > 5:
		length = 5
	else:
		pass 
		
func it_is_coming():
	print("IT IS COMING")
	if distance > 1:
		$CabScreen/Control/Command.text = "IT IS COMING"
		$Audio/ItIsComing.play()
		
	await get_tree().create_timer(1.5).timeout
	$CabScreen/Control/Command.text = ""
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


func _on_swipe_animation_finished() -> void:
	
	$CabScreen.animation = "it_has_you_1"
	await get_tree().create_timer(2).timeout
	$CabScreen.animation = "it_has_you_2"
	$CabScreen/Crunch.emitting = true
	$Audio/CrunchSound.play()
	await get_tree().create_timer(2).timeout
	$CabScreen.animation = "it_has_you_3"
	await get_tree().create_timer(2).timeout
	$CabScreen.play("leaving")
	$CabScreen/Control/Command.text = "Final Score: " + str(score)
	
func _on_cab_screen_animation_finished() -> void:
	get_tree().quit()


func _on_it_is_coming_finished() -> void:
	$Audio/FootSteps.play()


func _on_time_left_timeout() -> void:
	it_is_coming()
