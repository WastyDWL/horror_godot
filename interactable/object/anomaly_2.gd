extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animation_tree.get_animation("new_animation")
