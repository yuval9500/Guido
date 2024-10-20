extends Control

func startDialogue(nameText ,dialogueText) -> void:
	self.visible = true
	$nameCon/Label.text = nameText
	$dialogueCon/Label.text = dialogueText
	
