extends StateMachine


func set_textbox(new_text: String) -> void:
	controlled_node.command_text_box.text = new_text
	
func append_textbox(new_text: String) -> void:
	controlled_node.command_text_box.text += new_text

func increment_score() -> void:
	controlled_node.score += 1
