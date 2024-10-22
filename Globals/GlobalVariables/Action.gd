extends Node

class_name Action

var isNameKnown: bool = false
var scaleStat: CombatEnums.Stat
var effectType: CombatEnums.EffectType
var numOfEffectDice: int
var effectDie: int
var extraEffectDie: int = 0

@warning_ignore("shadowed_variable", "shadowed_variable_base_class")
func _init(name: String, scaleStat: CombatEnums.Stat, effectType: CombatEnums.EffectType,\
 numOfEffectDice: int, effectDie: int, extraEffectDie: int = 0) -> void:
	self.name = name
	self.scaleStat = scaleStat
	self.effectType = effectType
	self.numOfEffectDice = numOfEffectDice
	self.effectDie = effectDie
	self.extraEffectDie = extraEffectDie
