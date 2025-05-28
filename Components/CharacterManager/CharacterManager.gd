class_name CharacterManager

# Interface for all command-driven characters

func walk(direction: Vector2, distance: float = -1.0) -> void:
	pass

func stop() -> void:
	pass

func look(direction: Vector2) -> void:
	pass

func play_idle_animation():
	pass

func play_walking_animation():
	pass
