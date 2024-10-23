extends TextureButton

class_name CombatEnemy

var enemy: Enemy

signal choseTarget(target: CombatEnemy)

func _ready() -> void:
	initEnemy()

func initEnemy():
	enemy = EnemyArchive.testEnemy

func _on_pressed() -> void:
	emit_signal("choseTarget", self)

func takeDamage(damage: int):
	enemy.takeDamage(damage)
	if(!enemy.isAlive):
		queue_free()

func takeHealing(healing: int):
	enemy.takeHealing(healing)

func getArmorClass() -> int:
	return enemy.armorClass
