extends CharacterBody2D

@export var target: Player_Script  # Drag the Player node here in the editor

var speed: float
var last_direction: Vector2 = Vector2.DOWN
var distanceToTarget: float = 40.0
var velocity_threshold := 1.0  # pixels per frame to ignore micro jitter

func _ready() -> void:
	if target != null:
		print("Companion has reference to player")
		speed = target.command_speed  # sync with player's command walking speed
	else:
		push_error("Target player not assigned!")

func _physics_process(_delta: float) -> void:
	if target.isUnderControl:
		speed = target.command_speed
	else:
		speed = target.speed

	calculate_velocity()
	handle_animation()
	move_and_slide()


func calculate_velocity():
	var to_target = target.global_position - global_position
	if to_target.length() > distanceToTarget:
		var direction = to_target.normalized()
		velocity = velocity.move_toward(direction * speed, 50)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 50)

func handle_animation():
	if velocity.length() > velocity_threshold:
		last_direction = velocity
		play_walking_animation()
	else:
		play_idle_animation()

func play_walking_animation():
	var abs_x = abs(last_direction.x)
	var abs_y = abs(last_direction.y)

	if abs_x > abs_y:
		if last_direction.x < 0:
			$AnimationPlayer.play("walking_left")
		else:
			$AnimationPlayer.play("walking_right")
	else:
		if last_direction.y < 0:
			$AnimationPlayer.play("walking_up")
		else:
			$AnimationPlayer.play("walking_down")

func play_idle_animation():
	var abs_x = abs(last_direction.x)
	var abs_y = abs(last_direction.y)

	if abs_x > abs_y:
		if last_direction.x < 0:
			$AnimationPlayer.play("idle_left")
		else:
			$AnimationPlayer.play("idle_right")
	else:
		if last_direction.y < 0:
			$AnimationPlayer.play("idle_up")
		else:
			$AnimationPlayer.play("idle_down")
