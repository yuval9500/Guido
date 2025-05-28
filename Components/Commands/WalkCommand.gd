extends Object
class_name WalkCommand

var direction: Vector2
var distance: float

func _init(_direction: Vector2, _distance := -1.0):
	direction = _direction
	distance = _distance

const CharacterManager = preload("res://Components/CharacterManager/CharacterManager.gd")

func execute(character) -> void:
	character.walk(direction, distance)
