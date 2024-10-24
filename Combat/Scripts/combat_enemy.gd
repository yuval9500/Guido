extends TextureButton

class_name CombatEnemy

var enemy: Enemy

signal choseTarget(target: CombatEnemy)
signal enemyDeath(enemy: CombatEnemy)
signal enemyAttack(enemy: CombatEnemy, targetPlayer: CombatPlayer, targetAction: Action)

func _ready() -> void:
	initEnemy()

func initEnemy():
	enemy = EnemyArchive.testEnemy

func _on_pressed() -> void:
	emit_signal("choseTarget", self)

func takeDamage(damage: int):
	enemy.takeDamage(damage)
	if(!enemy.isAlive):
		emit_signal("enemyDeath", self)

func takeHealing(healing: int):
	enemy.takeHealing(healing)

func getArmorClass() -> int:
	return enemy.armorClass

func getScalingStat(stat: CombatEnums.Stat):
	return enemy.enemyStats[stat]

func playTurn(players: Array):
	#choose random alive player
	var targetPlayer = players.pick_random()
	
	#choose random action
	var targetAction = enemy.actions.pick_random()
	
	#do the action on that player
	emit_signal("enemyAttack", self, targetPlayer, targetAction)
