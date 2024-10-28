extends Control

@onready var audio_music_player = $MenuAudio
@onready var audio_sfx_player = $SfxAudio
@onready var volume_slider = $OptionsGroup/Music/MusicScrollBar
@onready var sfx_slider = $OptionsGroup/SFX/SfxScrollBar

func _ready() -> void:
	var saved_music_volume = load_music_volume()
	var saved_sfx_volume = load_sfx_volume()
	audio_music_player.volume_db = saved_music_volume
	audio_sfx_player.volume_db = saved_music_volume
	volume_slider.value = saved_music_volume
	sfx_slider.value = saved_sfx_volume
	
func _on_new_btn_pressed() -> void:
	print("Play Btn Was Pressed")
	audio_sfx_player.play()
	$TransitionManager.transitionToScene("res://TestLevel/Scenes/Test_Map.tscn")
	
func _on_options_btn_pressed() -> void:
	print("Options Btn Was Pressed")
	audio_sfx_player.play()
	$MenuGroup.visible = false	
	$OptionsGroup.visible = true

func _on_done_btn_pressed() -> void:
	print("Done Btn Was Pressed")
	audio_sfx_player.play()
	save_music_volume(audio_music_player.volume_db)
	save_sfx_volume(audio_sfx_player.volume_db)
	$OptionsGroup.visible = false
	$MenuGroup.visible = true	
	
func _on_exit_btn_pressed() -> void:
	print("Exit Btn Was Pressed")
	audio_sfx_player.play()
	get_tree().quit()

func _on_music_scroll_bar_value_changed(value: float) -> void:
	audio_music_player.volume_db = value

func save_music_volume(value: float) -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "volume_db", value)
	config.save("user://settings.cfg")

func load_music_volume() -> float:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		return config.get_value("audio", "volume_db", -20.0) 
	return -20.0
	
func _on_sfx_scroll_bar_value_changed(value: float) -> void:
	audio_sfx_player.volume_db = value
	
func save_sfx_volume(value: float) -> void:
	var config = ConfigFile.new()
	config.set_value("sfx", "volume_db", value)
	config.save("user://settings.cfg")
	
func load_sfx_volume() -> float:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		return config.get_value("sfx", "volume_db", 0) 
	return -20.0
	
func _on_cancel_btn_pressed() -> void:
	audio_sfx_player.play()
	var saved_music_volume = load_music_volume()
	audio_music_player.volume_db = saved_music_volume
	volume_slider.value = saved_music_volume
	var saved_sfx_volume = load_sfx_volume()
	audio_sfx_player.volume_db = saved_sfx_volume
	sfx_slider.value = saved_sfx_volume
	$OptionsGroup.visible = false
	$MenuGroup.visible = true	
