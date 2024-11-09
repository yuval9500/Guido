extends Node

var defaultPlayer: Player = Player.new("[]", 10, 1,0,[],[],[],0,0,0,0,0,0)

var player1Attacks: Array[Attack] = [ActionArchive.stormbreaker, ActionArchive.quarterstaff]
var player1Spells: Array[Spell] = [ActionArchive.firebolt, ActionArchive.cureWounds]
var player1Items: Array[Item] = [ActionArchive.healingPotion]

var player2Attacks: Array[Attack] = [ActionArchive.quarterstaff]
var player2Spells: Array[Spell] = [ActionArchive.cureWounds]
var player2Items: Array[Item] = [ActionArchive.healingPotion, ActionArchive.ringOfFireball]

var player1: Player = Player.new("player1", 10, 15, 10, player1Attacks, player1Spells, player1Items,\
2,2,2,2,2,2)
var player2: Player = Player.new("player2", 10, 10, 8, player2Attacks, player2Spells, player2Items,\
1,1,1,1,1,1)

#TODO change player names
var players: Dictionary = {"Player1":player1, "Player2":player2}

func findPlayerByName(playerName: String):
	return players[playerName]
