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
var dialogueUI: DialogueUI
var playerInventoryUI

func _ready() -> void:
	pauseMenu = get_tree().get_root().find_child("PauseMenu",true,false)
	dialogueUI = get_tree().get_root().find_child("DialogueUI",true,false)
	playerInventoryUI = get_tree().get_root().find_child("PlayerInventoryUI",true,false)

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if playerInventoryUI.visible:
			playerInventoryUI.visible = false
		elif pauseMenu.visible:
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
	elif event.is_action_pressed("inventory") and not GameManager.isPaused and not dialogueUI.visible:
		playerInventoryUI.visible = not playerInventoryUI.visible

func get_input():
	if GameManager.isPaused:
		velocity = Vector2.ZERO
		return
		
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction != Vector2.ZERO:
		isMoving = true
	else:
		isMoving = false
	
	velocity = input_direction * speed
