extends ProgressBar
@onready var stamina_bar: ProgressBar = $"."

func is_enough(min_value: int) -> bool:
	if stamina_bar.value > min_value:
		return true
	else:
		return false
		

func recoverry(rate):
	if stamina_bar.value < stamina_bar.max_value:
		stamina_bar.value += 2.5 * rate
		

		
		
