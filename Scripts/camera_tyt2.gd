extends Camera3D
@onready var camera_3d = $"../../../.."




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transform = camera_3d.transform
