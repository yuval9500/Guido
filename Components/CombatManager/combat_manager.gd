extends Control

var mouseTargetPNG = load("res://Combat/Sprites/target.png")

var players: Array
var enemies: Array

var activePlayers: Array
var alivePlayers: Array

var actingPlayer: CombatPlayer
var chosenAction: Action
var chosenTarget

func _ready() -> void:
	players = get_tree().get_root().find_child("Players",true,false).get_children()
	enemies = get_tree().get_root().find_child("Enemies",true,false).get_children()
	
	alivePlayers = players.duplicate()
	
	for player in players:
		player.clickedCombatMenu.connect(unfocusPlayers)
		player.choseAction.connect(playerChoseAction)
		player.choseTarget.connect(playerChoseTarget)
		player.playerDeath.connect(playerDeath)
	
	for enemy in enemies:
		enemy.choseTarget.connect(playerChoseTarget)
		enemy.enemyDeath.connect(enemyDeath)
		enemy.enemyAttack.connect(enemyAttack)
	
	startPlayersTurn()

func startPlayersTurn():
	activePlayers = alivePlayers.duplicate()
	for player in activePlayers:
		player.startTurn()
	print("player turn start")

func _on_unfocus_btn_pressed() -> void:
	unfocusPlayers()

func unfocusPlayers():
	returnMouseToNormal()
	actingPlayer = null
	chosenAction = null
	
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
		if(chosenAction is Spell and actingPlayer.canPlayerCast(chosenAction)):
			actingPlayer.removeSpellSlots(chosenAction.spellLevel)
		
		fullActionProcess(actingPlayer, target, chosenAction)
		
		endPlayerTurn(actingPlayer)
		unfocusPlayers()
		
		if (!checkPlayersWin()):
			checkCombatTurn()

func enemyAttack(enemy: CombatEnemy, targetPlayer: CombatPlayer, action: Action):
	fullActionProcess(enemy, targetPlayer, action)
	
	checkEnemiesWin()

func checkPlayersWin() -> bool:
	if(enemies.is_empty()):
		for player in activePlayers:
			endPlayerTurn(player)
		print("You Win!")
		#TODO go back to the map you came from at the same location
		return true
	return false

func checkEnemiesWin():
	if(alivePlayers.is_empty()):
		print("You Dieded!")
		#TODO think about what happens here, maybe load last save?

func fullActionProcess(performer, target, action: Action):
	#do the action:
	print("performer:", performer.name, " used action:", action.name, " to target:", target.name)
	
	var scalingStat = 0
	if (action.scaleStat != CombatEnums.Stat.NONE):
		scalingStat = performer.getScalingStat(action.scaleStat)
	#Damage
	if(action.effectType == CombatEnums.EffectType.DAMAGE):
		#Attack roll
		if(attackRoll(scalingStat, target)):
			#Damage Roll
			target.takeDamage(action.effectValueCalc(scalingStat))
	#Healing
	elif(action.effectType == CombatEnums.EffectType.HEALING):
		target.takeHealing(action.effectValueCalc(scalingStat))
	
	if(action is Item):
		performer.reduceUseOfItem(chosenAction)

func attackRoll(scalingStat: int, target):
	var attackRollValue = randi_range(1,20) + scalingStat + 2
	print("Attack roll:", attackRollValue, " vs AC:", target.getArmorClass())
	if (attackRollValue >= target.getArmorClass()):
		print("Hit")
		return true
	print("No hit")
	return false

func endPlayerTurn(player: CombatPlayer):
	activePlayers.erase(player)
	player.endTurn()

func checkCombatTurn():
	if(activePlayers.is_empty()):
		enemiesTurn()
		startPlayersTurn()

func enemiesTurn():
	print("Enemies Turn")
	for enemy in enemies:
		if (!alivePlayers.is_empty()):
			enemy.playTurn(alivePlayers)

func playerDeath(player: CombatPlayer):
	alivePlayers.erase(player)
	endPlayerTurn(player)
	checkCombatTurn()
	player.disabled = true

func enemyDeath(enemy: CombatEnemy):
	enemies.erase(enemy)
	enemy.queue_free()
