extends CharacterBody2D

class_name Player_Script

@export var speed = 400:
	get:
		return speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
