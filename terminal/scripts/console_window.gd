extends PanelContainer
@onready var input_bar = $VBoxContainer/InputBar
@onready var display: RichTextLabel = $VBoxContainer/ScrollContainer/Display

@export var message_buffer_limit = 100
var message_buffer: Array[String] = []

func push_message(message):
	message_buffer.push_back(message)
	if message_buffer.size() > message_buffer_limit:
		message_buffer.remove_at(0)
	
	display.bbcode_text = "\n".join(message_buffer)
	
func clear_output():
	message_buffer = []
	display.bbcode_text = ""
	

func _on_input_bar_text_submitted(input: String) -> void:
	input_bar.clear()
	if input.length() == 0:
		return
	push_message(input)
