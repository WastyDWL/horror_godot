extends Area3D

class_name Interactable

# Emitted when an Interactor starts looking at me.
signal focused(interactor: Interactor)
# Emitted when an Interactor stops looking at me.
signal unfocused(interactor: Interactor)
# Emitted when an Interactor interacts with me.
signal interacted(interactor: Interactor)




func _on_focused(interactor: Variant) -> void:
	print("not interacted")



func _on_interacted(interactor: Interactor) -> void:
	print("interacted 1")


func _on_unfocused(interactor: Interactor) -> void:
	print("not interacted 2")
