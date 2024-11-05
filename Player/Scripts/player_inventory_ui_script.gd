extends CanvasLayer

var playerButtons: Array
var optionButtons: Array
var inventoryTabs: Array

func _ready() -> void:
	playerButtons = $Control/LeftMenusContainer/PlayerSelection/PlayersContainer.get_children()
	optionButtons = $Control/LeftMenusContainer/OptionsSelection/OptionsContainer.get_children()
	inventoryTabs = $Control/Inventory/Tabs.get_children()
	for playerButton in playerButtons:
		playerButton.pressed.connect(toggleButtonPressed.bind(playerButton, playerButtons))
	for optionButton in optionButtons:
		optionButton.pressed.connect(toggleButtonPressed.bind(optionButton, optionButtons))
	for inventoryTab in inventoryTabs:
		inventoryTab.pressed.connect(toggleButtonPressed.bind(inventoryTab, inventoryTabs))

func toggleButtonPressed(pressedButton: Button, allButtons: Array):
	pressedButton.button_pressed = true
	for button in allButtons:
		if button != pressedButton:
			button.button_pressed = false
