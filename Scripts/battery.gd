extends Node3D

var player_infort = false

@onready var battery_2 = $"."

func _input(event):
	if Input.is_action_just_pressed("flashlitght"):
		if player_infort == true:
			battery_2.visable = !battery_2.visable
	
	



func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		player_infort = true
		print("interact")


func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		player_infort = false
