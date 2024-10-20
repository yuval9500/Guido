extends CharacterBody2D

class_name Player_Script

@export var speed = 400:
	get:
		return speed
		
var canInteract = false:
	set(value):
		canInteract = value

func _physics_process(_delta):
	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _input(event: InputEvent) -> void:
	dialogue(event)
	
func dialogue(event: InputEvent) -> void:
	if canInteract and event.is_action_pressed("talk"):
		print("pressed e")
