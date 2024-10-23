extends Node

var testEnemyActions: Array[Action] = [ActionArchive.quarterstaff, ActionArchive.firebolt]

var testEnemy: Enemy:
	get:
		return Enemy.new("test", 20, 10, testEnemyActions, 0,0,0,0,0,0)
