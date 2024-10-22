extends TextureButton

class_name CombatPlayer

@export var playerSprite: Resource = preload("res://Player/Sprites/Player_Sprite.png")

var combatMenu: ColorRect
var attackIndicator: ColorRect
var magicIndicator: ColorRect
var itemIndicator: ColorRect
var healthBar: TextureProgressBar
var combatOptionBtns: Array

var player: Player

signal clickedCombatMenu
signal choseAction(player: Node2D, optionBtnText: String)
signal choseTarget(target: CombatPlayer)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		player = PlayersGlobals.player1
	elif (name == "player2"):
		player = PlayersGlobals.player2
	else:
		player = PlayersGlobals.defaultPlayer

func initHealthBar():
	healthBar.max_value = player.maxHealth
	healthBar.value = player.currHealth

func updateHealthBar():
	healthBar.value = player.currHealth

func updateCombatMenu(title: String, options: Array):
	emit_signal("clickedCombatMenu")
	combatMenu.find_child("Title").text = title
	
	for optionBtn in combatOptionBtns:
		optionBtn.text = "---"
	
	for i in options.size():
		combatMenu.get_child(i+1).text = options[i].name
	
	for optionBtn in combatOptionBtns:
		if(optionBtn.text == "---"):
			optionBtn.disabled = true
		else:
			optionBtn.disabled = false

func _on_attack_btn_pressed() -> void:
	updateCombatMenu("Attacks:", player.attacks)
	combatMenu.visible = true
	attackIndicator.visible = true
	magicIndicator.visible = false
	itemIndicator.visible = false


func _on_magic_btn_pressed() -> void:
	updateCombatMenu("Spells:", player.spells)
	combatMenu.visible = true
	attackIndicator.visible = false
	magicIndicator.visible = true
	itemIndicator.visible = false


func _on_item_btn_pressed() -> void:
	updateCombatMenu("Items:", player.items)
	combatMenu.visible = true
	attackIndicator.visible = false
	magicIndicator.visible = false
	itemIndicator.visible = true


func unfocusCombatMenu() -> void:
	combatMenu.visible = false
	attackIndicator.visible = false
	magicIndicator.visible = false
	itemIndicator.visible = false

func playerChoseAction(optionBtn: Button):
	emit_signal("choseAction", self, optionBtn.text)

func _on_pressed() -> void:
	emit_signal("choseTarget", self)

func getScalingStat(stat: CombatEnums.Stat):
	return player.playerStats[stat]

func takeDamage(damage: int):
	player.takeDamage(damage)
	updateHealthBar()

func takeHealing(healing: int):
	player.takeHealing(healing)
	updateHealthBar()
