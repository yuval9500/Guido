extends Node2D

var target: Player_Script

func _ready() -> void:
	target = get_tree().get_root().find_child("Player",true,false)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered")
	if target:
		target.canInteract = true
	pass

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("body exited")
	if target:
		target.canInteract = false
	pass 
