extends Control

var mouseTargetPNG = load("res://Combat/Sprites/target.png")

var players: Array
var enemies: Array

var activePlayers: Array

var actingPlayer: CombatPlayer
var chosenAction: Action
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
	
	startPlayersTurn()

func startPlayersTurn():
	activePlayers = players.duplicate()
	for player in activePlayers:
		player.startTurn()

func _on_unfocus_btn_pressed() -> void:
	unfocusPlayers()

func unfocusPlayers():
	returnMouseToNormal()
	actingPlayer = null
	chosenAction = null
	chosenTarget = null
	
	for player in players:
		player.unfocusCombatMenu()

func returnMouseToNormal():
	Input.set_custom_mouse_cursor(null)
	
@warning_ignore("shadowed_variable")
func playerChoseAction(player: CombatPlayer, chosenAction: Action):
	Input.set_custom_mouse_cursor(mouseTargetPNG, Input.CURSOR_ARROW, Vector2(32, 32))
	actingPlayer = player
	
	self.chosenAction = chosenAction

func playerChoseTarget(target):
	if(actingPlayer):
		chosenTarget = target
		var scalingStat = 0
		if (chosenAction.scaleStat != CombatEnums.Stat.NONE):
			scalingStat = actingPlayer.getScalingStat(chosenAction.scaleStat)
		
		#do the action:
		print("player: ", actingPlayer.name,\
		 " action: ", chosenAction.name, " target: ", chosenTarget.name)
		
		if(chosenAction is Spell and actingPlayer.canPlayerCast(chosenAction)):
			actingPlayer.removeSpellSlots(chosenAction.spellLevel)
		
		if(chosenAction.effectType == CombatEnums.EffectType.DAMAGE):
			if(attackRoll(scalingStat, target)):
				target.takeDamage(chosenAction.effectValueCalc(scalingStat))
		elif(chosenAction.effectType == CombatEnums.EffectType.HEALING):
			target.takeHealing(chosenAction.effectValueCalc(scalingStat))
		
		if(chosenAction is Item):
			actingPlayer.reduceUseOfItem(chosenAction)
		
		actingPlayer.endTurn()
		removeActivePlayer(actingPlayer)
		checkPlayersTurn()
		
		unfocusPlayers()

func removeActivePlayer(player: CombatPlayer):
	activePlayers.erase(player)

func checkPlayersTurn():
	if(activePlayers.is_empty()):
		#TODO wait until enemies turn
		startPlayersTurn()

func attackRoll(scalingStat: int, target):
	var attackRollValue = randi_range(1,20) + scalingStat + 2
	print(attackRollValue, " vs ", target.getArmorClass())
	if (attackRollValue >= target.getArmorClass()):
		return true
	return false
