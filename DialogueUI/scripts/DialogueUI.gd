extends CanvasLayer

class_name DialogueUI

signal dialogue_finished 

@onready var typing_timer = $Timer
var dialogue_lines: Array = []
var dialogue_line: String = ""  
var char_index: int = 0
var lineIndex: int = 0
var typing_speed: float = 0.05
var skip_typing: bool = false
var waiting_for_next_line: bool = false  
var started: bool = false
var name_texts: Array = []
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
var sfx: AudioStream = null

func _ready():
	add_child(audio_player)

func startDialogue(nameTexts: Array, dialogueTexts: Array, sfxSound: String) -> void:
	sfx = load("res://Audio/Sfx/" + sfxSound) as AudioStream
	
	if sfx == null:
		print("Error: Unable to load the .wav file: " + sfxSound)
	else:
		audio_player.stream = sfx
		
	audio_player.volume_db = AudioManager.load_sfx_volume()
	
	lineIndex = 0
	self.visible = true
	name_texts = nameTexts
	dialogue_lines = dialogueTexts 
	set_name_and_start_line(lineIndex)

func set_name_and_start_line(index: int) -> void:
	$nameCon/nameLabel.text = name_texts[index]
	startLine(dialogue_lines[index])

func startLine(dialogueLine: String) -> void:
	char_index = 0
	$dialogueCon/dialogueLabel.text = ""
	dialogue_line = dialogueLine 
	skip_typing = false
	waiting_for_next_line = false 
	typing_timer.wait_time = typing_speed
	typing_timer.start()
	started = true

func _input(event):
	if started and not GameManager.isPaused and event.is_action_pressed("skip"):
		if waiting_for_next_line:
			lineIndex += 1
			if lineIndex < dialogue_lines.size():
				set_name_and_start_line(lineIndex)
			else:
				endDialogue()  
		else:
			skip_typing = true 

func _on_timer_timeout() -> void:
	if skip_typing:
		$dialogueCon/dialogueLabel.text = dialogue_line
		typing_timer.stop()
		waiting_for_next_line = true  
		return

	if char_index < dialogue_line.length():
		$dialogueCon/dialogueLabel.text += dialogue_line[char_index]
		char_index += 1
		
		if audio_player.stream != null:
			audio_player.play()
	else:
		typing_timer.stop()
		waiting_for_next_line = true  

func endDialogue() -> void:
	print("Dialogue finished")
	self.visible = false
	started = false
	emit_signal("dialogue_finished")
	
func endDialogueOnExit() -> void:
	print("Dialogue finished upon exit")
	self.visible = false
	started = false
