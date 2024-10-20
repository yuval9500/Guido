extends Area2D

var player: Player_Script
var isPlayerInBounds: bool = false
var isPlayerMoving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("Player",true,false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(isPlayerInBounds):
		isPlayerMoving = player.isMoving
	if(isPlayerInBounds and isPlayerMoving):
		var randomValue = randi_range(1,400)
		if(randomValue == 1):
			get_tree().change_scene_to_file("res://TestCombatLevel/test_combat_level.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		isPlayerInBounds = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		isPlayerInBounds = false
