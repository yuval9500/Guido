extends Node

@export var isPaused: bool = false

func pauseGame() -> void:
	isPaused = true

func resumeGame() -> void:
	isPaused = false
