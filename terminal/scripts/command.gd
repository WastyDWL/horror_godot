extends Node
enum ArgumentType{
	FLOAT,
	INT,
	STRING
}

var argument_names: Array[String] = []
var argument_types: Array[ArgumentType] = []

var callback: String:
	set = callback_set, get = callback_get
	
func callback_set(string):
	callback = "on_comand" + string

func callback_get():
	return callback

func _ready():
	assert(argument_types.size() == argument_names.size())
	assert(name.find(" ") == -1)
	name = name.to_lower()

func parse_argument(args: String):
	var arg_array = []
	var segmented = args.split(" ", false)
	var grouped: Array[String] = []
	
	var quoted = false
	for segment in segmented:
		if segment.begins_with("\""):
			quoted = true
			segment.erase(0, 1) #Remove quotaion mark
		if segment.ends_with("\""):
			quoted = false
			segment.erase(segment.length() - 1, 1) #Remove quotaion mark
			grouped.push_back(segment)
			segment = " ".join(grouped)
			grouped = []
			
		if quoted:
			grouped.push_back(segment)
		else:
			arg_array.push_back(segment)
	
	#Incomplete quote
	if grouped.size() != 0:
		return  "Incomplete argument format (Incomplete quote):" + " ".join(grouped)
		
	#Invalid number or argument
	if arg_array.size() != argument_types.size():
		return "Invalid number or arguments (Expected: %s, Recieved: %s)" % [
			str(argument_types.size()),
			str(arg_array.size())
		]
		
	#Convert array elements into their actual type
	for i in range(argument_names.size()):
		match(argument_types[i]):
			ArgumentType.FLOAT:
				arg_array[i] = float(arg_array[i])
			ArgumentType.INT:
				arg_array[i] = int(arg_array[i])
				
	return arg_array
func get_usage():
	var usage = "Usage: %s" % name
	
	for i in range(argument_types.size()):
		var arg_type = ArgumentType.keys()[argument_types[i]]
		var arg_name = argument_names[i]
		arg_name = arg_name.to_lower()
		arg_type = arg_type.to_lower()
		
		usage += "<%s:%s" % [arg_name, arg_type]
	return usage
	
func get_namespace_to(target: Node):
	var _namespace: Array[String] = []
	var node = self
	while  node != target:
		_namespace.insert(0, node.name)
		node = node.get_parent()
	return _namespace
