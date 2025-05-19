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
var last_direction := Vector2.DOWN  # Default facing down

func _ready() -> void:
	pauseMenu = get_tree().get_root().find_child("PauseMenu", true, false)

func _physics_process(_delta):
	get_input()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if pauseMenu.visible:
			var menuGroup = pauseMenu.find_child("MenuGroup")
			var optionGroup = pauseMenu.find_child("OptionsGroup")
			if optionGroup.visible:
				optionGroup.visible = false
				menuGroup.visible = true
			GameManager.resumeGame()
			pauseMenu.visible = false
		else:
			GameManager.pauseGame()
			pauseMenu.visible = true

func get_input():
	if GameManager.isPaused:
		velocity = Vector2.ZERO
		return

	var input_direction = Input.get_vector("left", "right", "up", "down")
	isMoving = input_direction != Vector2.ZERO

	if isMoving:
		last_direction = input_direction
		if input_direction.x < 0:
			$AnimationPlayer.play("walking_left")
		elif input_direction.x > 0:
			$AnimationPlayer.play("walking_right")
		elif input_direction.y > 0:
			$AnimationPlayer.play("walking_down")
		elif input_direction.y < 0:
			$AnimationPlayer.play("walking_up")
	else:
		if last_direction.x < 0:
			$AnimationPlayer.play("idle_left")
		elif last_direction.x > 0:
			$AnimationPlayer.play("idle_right")
		elif last_direction.y > 0:
			$AnimationPlayer.play("idle_down")
		elif last_direction.y < 0:
			$AnimationPlayer.play("idle_up")

	velocity = input_direction * speed
