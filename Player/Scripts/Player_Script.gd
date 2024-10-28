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
		
var pauseMenu: PauseMenu

func _ready() -> void:
	pauseMenu = get_tree().get_root().find_child("PauseMenu",true,false)

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if pauseMenu.visible:
			pauseMenu.visible = false
		else:
			pauseMenu.visible = true

func get_input():
	if GameManager.isPaused:
		return
		
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction != Vector2.ZERO:
		isMoving = true
	else:
		isMoving = false
	
	velocity = input_direction * speed
