extends TextureButton

class_name CombatEnemy

@export var enemyHP: int = 10

signal choseTarget(target: CombatEnemy)

func _on_pressed() -> void:
	emit_signal("choseTarget", self)
