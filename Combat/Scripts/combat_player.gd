extends TextureButton

class_name CombatPlayer

@export var playerSprite: Resource = preload("res://Player/Sprites/Player_Sprite.png")

var combatMenu: ColorRect
var attackIndicator: ColorRect
var magicIndicator: ColorRect
var itemIndicator: ColorRect

var attackOptions: Array = ["Attacks:", "Stormbreaker", "", ""]
var spellOptions: Array = ["Spells:", "Firebolt", "", ""]
var itemOptions: Array = ["Items:", "Health potion", "Ring of Fireball", ""]

var combatOptionBtns: Array

signal clickedCombatMenu
signal choseAction(player: Node2D, optionBtnText: String)
signal choseTarget(target: CombatPlayer)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combatMenu = $CombatMenu
	attackIndicator = $AttackIndicator
	magicIndicator = $MagicIndicator
	itemIndicator = $ItemIndicator
	texture_normal = playerSprite
	
	combatOptionBtns = combatMenu.get_children().slice(1,3)
	for optionBtn in combatOptionBtns:
		optionBtn.pressed.connect(playerChoseAction.bind(optionBtn))

func updateCombatMenu(options: Array):
	emit_signal("clickedCombatMenu")
	combatMenu.find_child("Title").text = options[0]
	combatMenu.find_child("Option1").text = options[1]
	combatMenu.find_child("Option2").text = options[2]
	combatMenu.find_child("Option3").text = options[3]

func _on_attack_btn_pressed() -> void:
	updateCombatMenu(attackOptions)
	combatMenu.visible = true
	attackIndicator.visible = true
	magicIndicator.visible = false
	itemIndicator.visible = false


func _on_magic_btn_pressed() -> void:
	updateCombatMenu(spellOptions)
	combatMenu.visible = true
	attackIndicator.visible = false
	magicIndicator.visible = true
	itemIndicator.visible = false


func _on_item_btn_pressed() -> void:
	updateCombatMenu(itemOptions)
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
