extends Node2D

var canInteract = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered")
	canInteract = true
	pass

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("body exited")
	canInteract = false
	pass 

func _input(event: InputEvent) -> void:
	dialogue(event)
	
func dialogue(event: InputEvent) -> void:
	if canInteract and event.is_action_pressed("talk"):
		$"../Player/DialogueUI".startDialogue("first","second")
		print("pressed e")
