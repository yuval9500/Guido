extends Action

class_name Item

var numOfUses: int = 1

@warning_ignore("shadowed_variable", "shadowed_variable_base_class")
func _init(name: String, numOfUses: int, scaleStat: CombatEnums.Stat, effectType: CombatEnums.EffectType,\
 numOfEffectDice: int, effectDie: int, extraEffectDie: int = 0) -> void:
	self.name = name
	self.scaleStat = scaleStat
	self.effectType = effectType
	self.numOfEffectDice = numOfEffectDice
	self.effectDie = effectDie
	self.extraEffectDie = extraEffectDie
	self.numOfUses = numOfUses
