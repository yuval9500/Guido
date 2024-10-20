extends CanvasLayer

class_name DialogueUI

func startDialogue(nameText ,dialogueText) -> void:
	self.visible = true
	$nameCon/nameLabel.text = nameText
	$dialogueCon/dialogueLabel.text = dialogueText

func stopDialogue() -> void:
	self.visible = false
