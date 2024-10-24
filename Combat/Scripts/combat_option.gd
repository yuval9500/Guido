extends Button

var action: Action

@warning_ignore("shadowed_variable")
func storeAction(action: Action):
	self.action = action
	self.text = action.name
	if(action is Spell):
		self.text += " (" + str(action.spellLevel) + ")"

func disable():
	self.disabled = true

func enable():
	self.disabled = false
