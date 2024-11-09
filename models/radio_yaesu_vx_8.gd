extends Node3D
@onready var sketchfab_scene = $"."


func _process(delta):
	sketchfab_scene.move_and_slide()
	
