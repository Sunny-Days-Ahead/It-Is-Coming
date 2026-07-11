extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NorthButton.button_pressed.connect(_on_button_pressed)
	$SouthButton.button_pressed.connect(_on_button_pressed)
	$EastButton.button_pressed.connect(_on_button_pressed)
	$WestButton.button_pressed.connect(_on_button_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed(pressed_button):
	print("pressed successfully " + str(pressed_button))
	if pressed_button == $NorthButton:
		print("north pressed")
	if pressed_button == $SouthButton:
		print("south pressed")
	if pressed_button == $EastButton:
		print("east pressed")
	if pressed_button == $WestButton:
		print("west pressed")
