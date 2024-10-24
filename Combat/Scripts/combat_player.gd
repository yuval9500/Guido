extends TextureButton

class_name CombatPlayer

@export var playerSprite: Resource = preload("res://Player/Sprites/Player_Sprite.png")

var actionMenu: Control
var combatMenu: ColorRect
var attackIndicator: ColorRect
var magicIndicator: ColorRect
var itemIndicator: ColorRect
var healthBar: TextureProgressBar
var combatOptionBtns: Array

var player: Player

signal clickedCombatMenu
signal choseAction(player: Node2D, chosenAction: Action)
signal choseTarget(target: CombatPlayer)
signal playerDeath(player)

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	actionMenu = $Actions
	combatMenu = $CombatMenu
	attackIndicator = $AttackIndicator
	magicIndicator = $MagicIndicator
	itemIndicator = $ItemIndicator
	healthBar = $HealthBar
	
	texture_normal = playerSprite
	
	initPlayer()
	initHealthBar()
	
	combatOptionBtns = combatMenu.get_children().slice(1,4)
	for optionBtn in combatOptionBtns:
		optionBtn.pressed.connect(playerChoseAction.bind(optionBtn))

func initPlayer():
	if (name == "player1"):
		player = PlayerGlobals.player1
	elif (name == "player2"):
		player = PlayerGlobals.player2
	else:
		player = PlayerGlobals.defaultPlayer

func initHealthBar():
	healthBar.max_value = player.maxHealth
	healthBar.value = player.currHealth

func startTurn():
	actionMenu.visible = true

func endTurn():
	actionMenu.visible = false

func updateHealthBar():
	healthBar.value = player.currHealth

func updateCombatMenu(title: String, options: Array):
	emit_signal("clickedCombatMenu")
	combatMenu.visible = true
	combatMenu.find_child("Title").text = title
	
	for optionBtn in combatOptionBtns:
		optionBtn.text = "---"
	
	for i in options.size():
		var currentOption = combatMenu.get_child(i+1)
		currentOption.enable()
		
		currentOption.storeAction(options[i])
		
		if(currentOption.action is Spell and !player.canCastSpell(currentOption.action)):
			currentOption.disable()
	
	for optionBtn in combatOptionBtns:
		if(optionBtn.text == "---"):
			optionBtn.disable()

func _on_attack_btn_pressed() -> void:
	updateCombatMenu("Attacks:", player.attacks)
	attackIndicator.visible = true
	magicIndicator.visible = false
	itemIndicator.visible = false


func _on_magic_btn_pressed() -> void:
	updateCombatMenu("Spells (" + str(player.currSpellSlots) + "):", player.spells)
	attackIndicator.visible = false
	magicIndicator.visible = true
	itemIndicator.visible = false


func _on_item_btn_pressed() -> void:
	updateCombatMenu("Items:", player.items)
	attackIndicator.visible = false
	magicIndicator.visible = false
	itemIndicator.visible = true


func unfocusCombatMenu() -> void:
	combatMenu.visible = false
	attackIndicator.visible = false
	magicIndicator.visible = false
	itemIndicator.visible = false

func playerChoseAction(optionBtn: Button):
	emit_signal("choseAction", self, optionBtn.action)

func _on_pressed() -> void:
	emit_signal("choseTarget", self)

func getScalingStat(stat: CombatEnums.Stat):
	return player.playerStats[stat]

func getArmorClass():
	return player.armorClass

func getSpellSlots():
	return player.currSpellSlots

func canPlayerCast(spellToCast: Spell) -> bool:
	return player.canCastSpell(spellToCast)

func removeSpellSlots(numOfSlots: int):
	player.removeSpellSlots(numOfSlots)

func takeDamage(damage: int):
	player.takeDamage(damage)
	updateHealthBar()
	
	if(!player.isAlive):
		emit_signal("playerDeath", self)

func takeHealing(healing: int):
	player.takeHealing(healing)
	updateHealthBar()

func reduceUseOfItem(usedItem: Item):
	player.reduceUseOfItem(usedItem)
