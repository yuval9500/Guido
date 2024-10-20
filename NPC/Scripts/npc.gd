extends Node2D

var canInteract = false
var dialogueUI: DialogueUI

func _ready() -> void:
	dialogueUI = get_tree().get_root().find_child("DialogueUI",true,false)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("body entered")
		canInteract = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("body exited")
		dialogueUI.stopDialogue()
		canInteract = false 

func _input(event: InputEvent) -> void:
	dialogue(event)
	
func dialogue(event: InputEvent) -> void:
	if canInteract and event.is_action_pressed("talk"):
		dialogueUI.startDialogue("first","second")
		print("pressed e")
