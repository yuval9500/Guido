extends Object
class_name StopCommand

const CharacterManager = preload("res://Components/CharacterManager/CharacterManager.gd")

func execute(character) -> void:
	character.stop()
