extends CanvasLayer

var sceneToMove: String

func _ready():
	visible = true
	transition_to_supreme()

	
func transition_to_black():
	$"AnimationPlayer".play("Supreme_To_Black")

func transition_to_supreme():
	$"AnimationPlayer".play("Black_To_Better")

func moveToScene():
	get_tree().change_scene_to_file(sceneToMove)

func hideMe():
	visible = false

func showMe():
	visible = true

func transitionToScene(scene: String) -> void:
	sceneToMove = scene
	transition_to_black()
	
