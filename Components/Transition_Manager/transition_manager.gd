extends CanvasLayer

var newScene: String

func _ready():
	showMe()
	transition_to_supreme()

func transition_to_black():
	$"AnimationPlayer".play("Supreme_To_Black")

func transition_to_supreme():
	$"AnimationPlayer".play("Black_To_Better")

func moveToScene():
	get_tree().change_scene_to_file(newScene)

func hideMe():
	visible = false

func showMe():
	visible = true

func transitionToScene(sceneToMoveTo: String, currentScene: String) -> void:
	PlayerGlobals.playersPreviousScene = currentScene
	print("Combat Encounter!")
	newScene = sceneToMoveTo
	transition_to_black()
	
