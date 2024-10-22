extends Node

class_name Action

var isNameKnown: bool = false
var scaleStat: CombatEnums.Stat
var effectType: CombatEnums.EffectType
var numOfEffectDice: int
var effectDie: int
var extraEffectDie: int = 0

func effectValueCalc(scalingStat: int):
	var sum = 0
	for i in range(0,numOfEffectDice):
		sum += randi_range(1,effectDie)
	if(extraEffectDie != 0):
		sum += randi_range(1,extraEffectDie)
	sum += scalingStat
	
	return sum

@warning_ignore("shadowed_variable", "shadowed_variable_base_class")
func _init(name: String, scaleStat: CombatEnums.Stat, effectType: CombatEnums.EffectType,\
 numOfEffectDice: int, effectDie: int, extraEffectDie: int = 0) -> void:
	self.name = name
	self.scaleStat = scaleStat
	self.effectType = effectType
	self.numOfEffectDice = numOfEffectDice
	self.effectDie = effectDie
	self.extraEffectDie = extraEffectDie
