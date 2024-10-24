extends CharacterBody2D

class_name Player_Script

@export var speed = 400:
	get:
		return speed

var isMoving: bool = false:
	get:
		return isMoving

var canInteract = false:
	set(value):
		canInteract = value

func _physics_process(_delta):
	get_input()
	move_and_slide()

func get_input():
	if GameManager.isPaused:
		return
		
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction != Vector2.ZERO:
		isMoving = true
	else:
		isMoving = false
	
	velocity = input_direction * speed
