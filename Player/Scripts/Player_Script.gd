extends CharacterBody2D

class_name Player_Script

@export var speed := 400  # normal movement speed
@export var command_speed := 50  # slower speed for scripted/cutscene movement

var isMoving: bool = false:
	get:
		return isMoving

var canInteract = false:
	set(value):
		canInteract = value

var pauseMenu: PauseMenu
var last_direction := Vector2.DOWN  # Default facing down

# Scripted movement state
var isUnderControl := false
var command_direction := Vector2.ZERO
var walk_target_distance: float = -1  # -1 means no distance limit
var walk_start_position: Vector2

func _ready() -> void:
	pauseMenu = get_tree().get_root().find_child("PauseMenu", true, false)

func _physics_process(_delta):
	get_input()
	move_and_slide()

	# Auto-stop if walked the intended distance
	if isUnderControl and walk_target_distance > 0:
		var walked_distance = global_position.distance_to(walk_start_position)
		if walked_distance >= walk_target_distance:
			print("Reached walk target distance")
			execute_command("stop")

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
	var input_direction: Vector2

	# Allow only scripted movement if paused
	if GameManager.isPaused:
		if isUnderControl:
			input_direction = command_direction
		else:
			velocity = Vector2.ZERO
			return
	else:
		input_direction = command_direction if isUnderControl else Input.get_vector("left", "right", "up", "down")

	isMoving = input_direction != Vector2.ZERO

	if isMoving:
		last_direction = input_direction
		play_walking_animation()
	else:
		play_idle_animation()

	# Apply movement velocity
	velocity = input_direction * (command_speed if isUnderControl else speed)

func execute_command(command: String):
	print("executing command:", command)

	# Handle walk(direction) or walk(direction, distance)
	if command.begins_with("walk("):
		var clean = command.replace("walk(", "").replace(")", "")
		var parts = clean.split(",")
		var direction = parts[0].strip_edges()
		var distance = float(parts[1].strip_edges()) if parts.size() > 1 else -1.0

		match direction:
			"left": command_direction = Vector2.LEFT
			"right": command_direction = Vector2.RIGHT
			"up": command_direction = Vector2.UP
			"down": command_direction = Vector2.DOWN
			_:
				print("Unknown walk direction")
				return

		isUnderControl = true
		walk_start_position = global_position
		walk_target_distance = distance
		return

	match command:
		"stop":
			isUnderControl = false
			isMoving = false
			command_direction = Vector2.ZERO
			walk_target_distance = -1
			play_idle_animation()

		"look(left)":
			last_direction = Vector2.LEFT
			play_idle_animation()

		"look(right)":
			last_direction = Vector2.RIGHT
			play_idle_animation()

		"look(up)":
			last_direction = Vector2.UP
			play_idle_animation()

		"look(down)":
			last_direction = Vector2.DOWN
			play_idle_animation()

		_:
			print("Unknown command: ", command)

func play_idle_animation():
	if last_direction.x < 0:
		$AnimationPlayer.play("idle_left")
	elif last_direction.x > 0:
		$AnimationPlayer.play("idle_right")
	elif last_direction.y > 0:
		$AnimationPlayer.play("idle_down")
	elif last_direction.y < 0:
		$AnimationPlayer.play("idle_up")

func play_walking_animation():
	if last_direction.x < 0:
		$AnimationPlayer.play("walking_left")
	elif last_direction.x > 0:
		$AnimationPlayer.play("walking_right")
	elif last_direction.y > 0:
		$AnimationPlayer.play("walking_down")
	elif last_direction.y < 0:
		$AnimationPlayer.play("walking_up")
