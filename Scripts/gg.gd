extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree
var state_machine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = animation_tree.get("parameters/conditions/animation_tree") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
