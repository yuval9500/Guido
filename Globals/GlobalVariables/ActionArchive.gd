extends Node

func findActionByName(actionName: String):
	return action[actionName]

#Attacks
var stormbreaker: Attack = Attack.new("Stormbreaker", CombatEnums.Stat.STRENGTH, 1, 8, 4)
var quarterstaff: Attack = Attack.new("Quarterstaff", CombatEnums.Stat.STRENGTH, 1, 6)

#Spells
var firebolt: Spell = Spell.new("Firebolt", 0,\
CombatEnums.Stat.INTELLIGENCE,CombatEnums.EffectType.DAMAGE, 1, 10)

var cureWounds: Spell = Spell.new("Cure Wounds", 1,\
CombatEnums.Stat.INTELLIGENCE, CombatEnums.EffectType.HEALING,2, 8)

#Items
var healingPotion: Item:
	get:
		return Item.new("Healing Potion", 1, CombatEnums.Stat.NONE,\
CombatEnums.EffectType.HEALING, 3, 4)

var ringOfFireball: Item:
	get:
		return Item.new("Ring of Fireball", 1, CombatEnums.Stat.INTELLIGENCE,\
CombatEnums.EffectType.DAMAGE, 8, 6)

var action :Dictionary = {"Stormbreaker":stormbreaker, "Quarterstaff":quarterstaff,\
"Firebolt":firebolt, "Cure Wounds":cureWounds, "Healing Potion":healingPotion,\
"Ring of Fireball":ringOfFireball}
