extends Object
class_name LookCommand

var direction: Vector2

func _init(_direction: Vector2):
	direction = _direction

const CharacterManager = preload("res://Components/CharacterManager/CharacterManager.gd")

func execute(character) -> void:
	character.look(direction)
