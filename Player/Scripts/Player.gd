extends Node

class_name Player

var isAlive: int = true

var maxHealth: int
var currHealth: int

var maxLevelOneSpellSlots: int
var currLevelOneSpellSlots: int

var maxLevelTwoSpellSlots: int
var currLevelTwoSpellSlots: int

var attacks: Array[Attack]
var spells: Array[Spell]
var items: Array[Item]

func takeDamage(damageNum: int):
	currHealth -= damageNum
	checkIfDead()

func takeHealing(healingNum: int):
	currHealth += healingNum

func checkIfDead():
	if currHealth <= 0:
		currHealth = 0
		isAlive = false

#Player Constructor
@warning_ignore("shadowed_variable", "shadowed_variable_base_class")
func _init(name: String, maxHealth: int, maxLevelOneSpellSlots: int, maxLevelTwoSpellSlots: int,\
attacks: Array[Attack], spells: Array[Spell], items:Array[Item]) -> void:
	self.name = name
	
	self.maxHealth = maxHealth
	self.currHealth = maxHealth
	
	self.maxLevelOneSpellSlots = maxLevelOneSpellSlots
	self.maxLevelTwoSpellSlots = maxLevelTwoSpellSlots
	
	self.currLevelOneSpellSlots = maxLevelOneSpellSlots
	self.currLevelTwoSpellSlots = maxLevelTwoSpellSlots
	
	self.attacks = attacks
	self.spells = spells
	self.items = items
	
