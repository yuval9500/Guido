extends CanvasLayer

@onready var dialogueTimer = $Timer
@onready var nameLabel = $nameCon/nameLabel
@onready var dialogueLabel = $dialogueCon/dialogueLabel

var nameLines = []
var dialogueLines = []
var actionLines = []

var dialogueIndex = 0
var currentText = ""
var currentLine = ""
var characterIndex = 0

var audioPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
var typingSound: AudioStream = null

func _ready():
	add_child(audioPlayer)
	audioPlayer.volume_db = AudioManager.load_sfx_volume()

func startDialogue(nameData: Array, dialogueData: Array, actionData: Array) -> void:
	visible = true
	nameLines = nameData
	dialogueLines = dialogueData
	actionLines = actionData
	dialogueIndex = 0

	if not dialogueTimer.timeout.is_connected(_on_DialogueTimer_timeout):
		dialogueTimer.timeout.connect(_on_DialogueTimer_timeout)

	_startNextLine()

func _startNextLine() -> void:
	if dialogueIndex < dialogueLines.size():
		currentLine = dialogueLines[dialogueIndex]
		characterIndex = 0
		currentText = ""
		dialogueLabel.text = ""
		nameLabel.text = nameLines[dialogueIndex]

		# Directly send command to $Player if action exists
		var action = actionLines[dialogueIndex]
		print("action: ",action)
		if action != "" and $"../Player".has_method("execute_command"):
			$"../Player".execute_command(action)

		dialogueTimer.start(0.05)
	else:
		print("Dialogue finished.")
		GameManager.resumeGame()
		visible = false

func _on_DialogueTimer_timeout() -> void:
	if characterIndex < currentLine.length():
		currentText += currentLine[characterIndex]
		dialogueLabel.text = currentText

		typingSound = load(AudioDictionary.AudioDict.get(nameLabel.text, "")) as AudioStream
		if typingSound != null:
			audioPlayer.stream = typingSound
			audioPlayer.play()

		characterIndex += 1
	else:
		dialogueTimer.stop()
		dialogueIndex += 1
		await get_tree().create_timer(1.0).timeout
		_startNextLine()
