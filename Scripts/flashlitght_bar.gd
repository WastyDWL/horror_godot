extends ProgressBar
@onready var flashlitght_bar: ProgressBar = $"../flashlitght_bar"
@onready var flashlitght = $Hand/SpotLight3D

func is_enough():
	flashlitght_bar.value -= 1
