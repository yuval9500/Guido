extends Control

var mouseTargetPNG = load("res://Combat/Sprites/target.png")

var players: Array
var enemies: Array

var actingPlayer: CombatPlayer
var chosenAction: String
var chosenTarget

func _ready() -> void:
	players = get_tree().get_root().find_child("Players",true,false).get_children()
	enemies = get_tree().get_root().find_child("Enemies",true,false).get_children()
	
	for player in players:
		player.clickedCombatMenu.connect(unfocusPlayers)
		player.choseAction.connect(playerChoseAction)
		player.choseTarget.connect(playerChoseTarget)
	
	for enemy in enemies:
		enemy.choseTarget.connect(playerChoseTarget)

func _on_unfocus_btn_pressed() -> void:
	unfocusPlayers()

func unfocusPlayers():
	returnMouseToNormal()
	actingPlayer = null
	chosenAction = ""
	chosenTarget = null
	
	for player in players:
		player.unfocusCombatMenu()

func returnMouseToNormal():
	Input.set_custom_mouse_cursor(null)
	
func playerChoseAction(player, actionText):
	Input.set_custom_mouse_cursor(mouseTargetPNG, Input.CURSOR_ARROW, Vector2(32, 32))
	actingPlayer = player
	chosenAction = actionText

func playerChoseTarget(target):
	if(actingPlayer):
		chosenTarget = target
		#do the action:
		print("player: ", actingPlayer.name, " action: ", chosenAction, " target: ", chosenTarget.name)
		unfocusPlayers()
