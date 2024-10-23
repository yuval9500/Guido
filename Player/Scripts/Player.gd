extends Node

class_name Player

var isAlive: int = true

var armorClass: int

var maxHealth: int
var currHealth: int

var maxSpellSlots: int
var currSpellSlots: int

var attacks: Array[Attack]
var spells: Array[Spell]
var items: Array[Item]

var playerStats: Dictionary = {\
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

func canCastSpell(spellToCast: Spell):
	if (currSpellSlots >= spellToCast.spellLevel):
		return true
	return false

func removeSpellSlots(numOfSlots):
	currSpellSlots -= numOfSlots

func reduceUseOfItem(usedItem: Item):
	var itemInArray = items[items.find(usedItem)]
	itemInArray.numOfUses -= 1
	if(itemInArray.numOfUses == 0):
		removeItem(itemInArray)

func removeItem(itemToRemove: Item):
	items.erase(itemToRemove)

#Player Constructor
@warning_ignore("shadowed_variable", "shadowed_variable_base_class")
func _init(name: String, armorClass: int, maxHealth: int, maxSpellSlots: int,\
attacks: Array[Attack], spells: Array[Spell], items:Array[Item], strengthValue:int,dexterityValue:int,\
constitutionValue: int, intelligenceValue: int, wisdomValue:int, charismaValue:int) -> void:
	self.name = name
	
	self.armorClass = armorClass
	
	self.maxHealth = maxHealth
	self.currHealth = maxHealth
	
	self.maxSpellSlots = maxSpellSlots
	self.currSpellSlots = maxSpellSlots

	self.attacks = attacks
	self.spells = spells
	self.items = items
	
	self.playerStats[CombatEnums.Stat.STRENGTH] = strengthValue
	self.playerStats[CombatEnums.Stat.DEXTERITY] = dexterityValue
	self.playerStats[CombatEnums.Stat.CONSTITUTION] = constitutionValue
	self.playerStats[CombatEnums.Stat.INTELLIGENCE] = intelligenceValue
	self.playerStats[CombatEnums.Stat.WISDOM] = wisdomValue
	self.playerStats[CombatEnums.Stat.CHARISMA] = charismaValue
	
