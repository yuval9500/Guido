extends Node

class_name Enemy

var isAlive: bool = true

var maxHealth: int
var currHealth: int

var armorClass: int

var actions: Array[Action]

var enemyStats: Dictionary = {\
CombatEnums.Stat.STRENGTH:0,\
CombatEnums.Stat.DEXTERITY:0,\
CombatEnums.Stat.CONSTITUTION:0,\
CombatEnums.Stat.INTELLIGENCE:0,\
CombatEnums.Stat.WISDOM:0,\
CombatEnums.Stat.CHARISMA:0}

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
func _init(name: String, maxHealth: int, armorClass: int, actions: Array[Action],\
strengthValue:int,dexterityValue:int,constitutionValue: int, intelligenceValue: int, wisdomValue:int, charismaValue:int):
	self.name = name
	self.maxHealth = maxHealth
	self.currHealth = maxHealth
	self.armorClass = armorClass
	self.actions = actions
	
	self.enemyStats[CombatEnums.Stat.STRENGTH] = strengthValue
	self.enemyStats[CombatEnums.Stat.DEXTERITY] = dexterityValue
	self.enemyStats[CombatEnums.Stat.CONSTITUTION] = constitutionValue
	self.enemyStats[CombatEnums.Stat.INTELLIGENCE] = intelligenceValue
	self.enemyStats[CombatEnums.Stat.WISDOM] = wisdomValue
	self.enemyStats[CombatEnums.Stat.CHARISMA] = charismaValue
