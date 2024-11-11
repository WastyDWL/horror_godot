extends Area3D

class_name Interactable

# Emitted when an Interactor starts looking at me.
signal focused(interactor: Interactor)
# Emitted when an Interactor stops looking at me.
signal unfocused(interactor: Interactor)
# Emitted when an Interactor interacts with me.
signal interacted(interactor: Interactor)

@onready var audio_stream_player = $"../AudioStreamPlayer"



func _on_focused(interactor: Variant) -> void:
	print("not interacted")
	audio_stream_player.play()



func _on_interacted(interactor: Interactor) -> void:
	print("interacted 1")


func _on_unfocused(interactor: Interactor) -> void:
	print("not interacted 2")
	audio_stream_player.stop()
