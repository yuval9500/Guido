extends CharacterBody2D

var target: Player_Script
var speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = $"../Player"
	speed = target.speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	calculate_velocity()
	
	#animation?
	
	move_and_slide()

func calculate_velocity():
	var distanceToTarget = 40
	var targetPosition = target.position
	
	if (position.distance_to(targetPosition) > distanceToTarget):
		var direction = (targetPosition - position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
