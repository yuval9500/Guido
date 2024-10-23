extends Node

class_name Enemy

var isAlive: bool = true

var maxHealth: int
var currHealth: int

var armorClass: int

var actions: Array[Action]

func takeDamage(damageNum: int):
	currHealth -= damageNum
	updateIsAlive()

func takeHealing(healingNum: int):
	if(isAlive):
		currHealth += healingNum
		if(currHealth > maxHealth):
			currHealth = maxHealth

func updateIsAlive():
	if currHealth <= 0:
		currHealth = 0
		isAlive = false

@warning_ignore("shadowed_variable_base_class", "shadowed_variable")
func _init(name: String, maxHealth: int, armorClass: int, actions: Array[Action]):
	self.name = name
	self.maxHealth = maxHealth
	self.currHealth = maxHealth
	self.armorClass = armorClass
	self.actions = actions
