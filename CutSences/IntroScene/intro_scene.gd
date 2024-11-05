extends Node2D

@onready var timer = $Control/CanvasLayer/Timer
@onready var dialogueBox = $Control/CanvasLayer/dialogueCon/dialogueLabel

var dialogue = []  # Store the dialogue array as a class variable
var dialogue_index = 0
var current_text = ""
var current_string = ""
var char_index = 0
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
var sfx: AudioStream = null

func _ready():
	add_child(audio_player)
	sfx = load("res://Audio/Sfx/narrator.mp3") as AudioStream
	
	if sfx == null:
		print("Error: Unable to load the .mp3 file: res://Audio/Sfx/narrator.mp3")
	else:
		audio_player.stream = sfx
		
	audio_player.volume_db = AudioManager.load_sfx_volume()

func StartDialogueCutScene(dialouge_data: Array) -> void:
	$Control/CanvasLayer.visible = true
	dialogue = dialouge_data
	dialogue_index = 0
	if not timer.timeout.is_connected(_on_Timer_timeout):
		timer.timeout.connect(_on_Timer_timeout)
	_start_next_string()

func _start_next_string() -> void:
	if dialogue_index < dialogue.size():
		
		current_string = dialogue[dialogue_index]
		char_index = 0
		current_text = ""
		dialogueBox.text = ""
		timer.start(0.05)  # Adjust this delay to control typing speed
	else:
		print("Finished")
		$Control/CanvasLayer.visible = false

func _on_Timer_timeout() -> void:
	if char_index < current_string.length():
		current_text += current_string[char_index]
		dialogueBox.text = current_text
		if audio_player.stream != null:
			audio_player.play()
		char_index += 1
	else:
		timer.stop()
		dialogue_index += 1
		await get_tree().create_timer(1.0).timeout  # Wait 1 second before the next line
		_start_next_string()

func changeScene() -> void:
	$TransitionManager.transitionToScene("res://TestLevel/Scenes/Test_Map.tscn")
