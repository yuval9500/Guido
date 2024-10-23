extends Action

class_name Attack

@warning_ignore("shadowed_variable", "shadowed_variable_base_class")
func _init(name: String, scaleStat: CombatEnums.Stat,\
numOfEffectDice: int, effectDie: int, extraEffectDie: int = 0) -> void:
	self.name = name
	self.scaleStat = scaleStat
	self.effectType = CombatEnums.EffectType.DAMAGE
	self.numOfEffectDice = numOfEffectDice
	self.effectDie = effectDie
	self.extraEffectDie = extraEffectDie
