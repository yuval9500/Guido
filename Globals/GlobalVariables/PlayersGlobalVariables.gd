extends Node

class_name PlayersGlobals

static var defaultPlayer: Player = Player.new("[]", 1,0,0,[],[],[],0,0,0,0,0,0)

static var player1Attacks: Array[Attack] = [ActionArchive.stormbreaker, ActionArchive.quarterstaff]
static var player1Spells: Array[Spell] = [ActionArchive.firebolt, ActionArchive.cureWounds]
static var player1Items: Array[Item] = [ActionArchive.healingPotion]

static var player2Attacks: Array[Attack] = [ActionArchive.quarterstaff]
static var player2Spells: Array[Spell] = [ActionArchive.cureWounds]
static var player2Items: Array[Item] = [ActionArchive.healingPotion, ActionArchive.ringOfFireball]

static var player1: Player = Player.new("player1", 15, 4, 3, player1Attacks, player1Spells, player1Items,\
2,2,2,2,2,2)
static var player2: Player = Player.new("player2", 10, 4, 3, player2Attacks, player2Spells, player2Items,\
1,1,1,1,1,1)
