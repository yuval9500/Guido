extends CharacterBody2D
class_name Player_Script

@export var speed := 400
@export var command_speed := 50

var isMoving: bool = false:
	get: return isMoving

var canInteract = false:
	set(value): canInteract = value

var pauseMenu: PauseMenu
var last_direction := Vector2.DOWN

# Movement state
var isUnderControl := false
var command_direction := Vector2.ZERO
var walk_target_distance: float = -1
var walk_start_position: Vector2

# Command references
const StopCommand = preload("res://Components/Commands/StopCommand.gd")
const WalkCommand = preload("res://Components/Commands/WalkCommand.gd")
const LookCommand = preload("res://Components/Commands/LookCommand.gd")
const CharacterManager = preload("res://Components/CharacterManager/CharacterManager.gd")

func _ready() -> void:
	pauseMenu = get_tree().get_root().find_child("PauseMenu", true, false)

func _physics_process(_delta):
	get_input()
	move_and_slide()

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

	velocity = input_direction * (command_speed if isUnderControl else speed)

func execute_command(command: String):
	print("executing command:", command)

	if command.begins_with("walk("):
		var clean = command.replace("walk(", "").replace(")", "")
		var parts = clean.split(",")
		var dir = parts[0].strip_edges()
		var dist = float(parts[1].strip_edges()) if parts.size() > 1 else -1.0

		var direction = Vector2.ZERO
		match dir:
			"left": direction = Vector2.LEFT
			"right": direction = Vector2.RIGHT
			"up": direction = Vector2.UP
			"down": direction = Vector2.DOWN

		if direction != Vector2.ZERO:
			var walk_cmd = WalkCommand.new(direction, dist)
			walk_cmd.execute(self)
		else:
			print("Unknown walk direction")
		return

	if command.begins_with("look("):
		var dir = command.replace("look(", "").replace(")", "").strip_edges()

		var direction = Vector2.ZERO
		match dir:
			"left": direction = Vector2.LEFT
			"right": direction = Vector2.RIGHT
			"up": direction = Vector2.UP
			"down": direction = Vector2.DOWN

		if direction != Vector2.ZERO:
			var look_cmd = LookCommand.new(direction)
			look_cmd.execute(self)
		else:
			print("Unknown look direction")
		return

	if command == "stop":
		var stop_cmd = StopCommand.new()
		stop_cmd.execute(self)
		return

	print("Unknown command: ", command)

# === CharacterManager interface ===

func walk(direction: Vector2, distance: float = -1.0) -> void:
	isUnderControl = true
	command_direction = direction
	walk_start_position = global_position
	walk_target_distance = distance

func stop() -> void:
	isUnderControl = false
	isMoving = false
	command_direction = Vector2.ZERO
	walk_target_distance = -1
	play_idle_animation()

func look(direction: Vector2) -> void:
	last_direction = direction
	play_idle_animation()

# === Animations ===

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
