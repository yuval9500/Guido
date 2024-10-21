extends Node2D

class_name CombatPlayer

var combatMenu: ColorRect
var attackIndicator: ColorRect
var magicIndicator: ColorRect
var itemIndicator: ColorRect

var attackOptions: Array = ["Attacks:", "Stormbreaker", "", ""]
var spellOptions: Array = ["Spells:", "Firebolt", "", ""]
var itemOptions: Array = ["Items:", "Health potion", "Ring of Fireball", ""]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combatMenu = $CombatPlayerUI/CombatMenu
	attackIndicator = $CombatPlayerUI/AttackIndicator
	magicIndicator = $CombatPlayerUI/MagicIndicator
	itemIndicator = $CombatPlayerUI/ItemIndicator


func updateCombatMenu(options: Array):
	combatMenu.find_child("Title").text = options[0]
	combatMenu.find_child("Option1").text = options[1]
	combatMenu.find_child("Option2").text = options[2]
	combatMenu.find_child("Option3").text = options[3]

func _on_attack_btn_pressed() -> void:
	combatMenu.visible = true
	attackIndicator.visible = true
	magicIndicator.visible = false
	itemIndicator.visible = false
	updateCombatMenu(attackOptions)


func _on_magic_btn_pressed() -> void:
	combatMenu.visible = true
	attackIndicator.visible = false
	magicIndicator.visible = true
	itemIndicator.visible = false
	updateCombatMenu(spellOptions)


func _on_item_btn_pressed() -> void:
	combatMenu.visible = true
	attackIndicator.visible = false
	magicIndicator.visible = false
	itemIndicator.visible = true
	updateCombatMenu(itemOptions)


func unfocusCombatMenu() -> void:
	combatMenu.visible = false
	attackIndicator.visible = false
	magicIndicator.visible = false
	itemIndicator.visible = false
