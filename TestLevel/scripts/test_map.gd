extends Node2D

var storyFile = "scenario0"

func _ready() -> void:
	var story = StoryManager.loadStory(storyFile)
	var result: Array = StoryManager.ParseLines(story)
	GameManager.pauseGame()
	$Narrator.startDialogue(result[0],result[1],result[2])
