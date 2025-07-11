extends PanelContainer
@onready var input_bar = $VBoxContainer/InputBar
@onready var display: RichTextLabel = $VBoxContainer/ScrollContainer/Display
const CommandModule = preload("res://terminal/scripts/command_module.gd")


var message_buffer_limit = 100
var message_buffer: Array[String] = []
var command_modules: Array = []

func add_command_module(module: CommandModule):
	module.console = self
	command_modules.push_back(module)

func push_message(message):
	message_buffer.push_back(message)
	if message_buffer.size() > message_buffer_limit:
		message_buffer.remove_at(0)
	
	display.bbcode_text = "\n".join(message_buffer)
	
func clear_output():
	message_buffer = []
	display.bbcode_text = ""
	
func parse_input(input):
	var tokenized = input.split(" ", false, 1)
	if tokenized.size() == 0:
		return
	
	var command = tokenized[0].to_lower()
	var command_module = null
	
	for module in command_modules:
		if module.has_command(command):
			command_module = module
			break
	
	if command_module == null:
		push_message("Command not found: " + command)
		return
		
	var args = ""
	if tokenized.size() >1:
		args = tokenized[1]
		
	command_module.command_entered(command, args)


func _on_input_bar_text_submitted(input: String) -> void:
	input_bar.clear()
	if input.length() == 0:
		return
	parse_input(input)
