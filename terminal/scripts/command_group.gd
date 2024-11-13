extends Node

func _ready():
	assert(name.find(" ") == -1) #No spaces
	name = name.to_lower() #Case-insensitive for simplicity
	
