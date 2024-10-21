extends Node2D

var canInteract = false
var finished = false
var npcName = "Baldude"
var npcDefaultMsg = "Good luck!"
var dialogueUI: DialogueUI

var storyFile = "scenario1"
var sfxSound = "baldudeSfx.wav"

func _ready() -> void:
	dialogueUI = get_tree().get_root().find_child("DialogueUI", true, false)
	dialogueUI.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("body entered")
		canInteract = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("body exited")
		canInteract = false 
		dialogueUI.endDialogueOnExit()

func _input(event: InputEvent) -> void:
	dialogue(event)
	
func dialogue(event: InputEvent) -> void:
	if canInteract and event.is_action_pressed("talk"):
		canInteract = false
		var names: Array = [npcName]
		var dialogues: Array = [npcDefaultMsg]
		if not finished:
			var story = StoryManager.loadStory(storyFile)
			var result: Array  = StoryManager.ParseLines(story)
			names = result[0]
			dialogues = result[1]
	
		dialogueUI.startDialogue(names, dialogues, sfxSound)
		print("pressed e")

func _on_dialogue_finished() -> void:
	canInteract = true
	finished = true
