extends Area2D

var player: Player_Script


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("Player",true,false)
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Label.visible = true
		$"Spacebar Image".visible = true
		
var space_press_count: int = 0
var target_press_count: int = 10

func _input(event):
	# Check if the event is a key press and if the key is the space bar
	if event is InputEventKey and event.is_action_pressed("space"):
		space_press_count+=1
		if space_press_count == target_press_count:
			queue_free()
