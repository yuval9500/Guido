extends TextureButton

class_name CombatEnemy

signal choseTarget(target: CombatEnemy)

func _on_pressed() -> void:
	emit_signal("choseTarget", self)
