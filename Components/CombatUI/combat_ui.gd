extends Control

var player: CombatPlayer

func _ready() -> void:
	player = get_tree().get_root().find_child("CombatPlayer",true,false)

func _on_unfocus_btn_pressed() -> void:
	player.unfocusCombatMenu()
