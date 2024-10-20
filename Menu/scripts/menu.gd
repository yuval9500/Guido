extends Control

@onready var audio_player = $MenuAudio
@onready var volume_slider = $OptionsGroup/Music/MusicScrollBar

func _ready() -> void:
	var saved_volume = load_volume()
	audio_player.volume_db = saved_volume
	volume_slider.value = saved_volume

func _on_menu_play_btn_pressed() -> void:
	print("Play Btn Was Pressed")
	pass

func _on_menu_options_btn_pressed() -> void:
	print("Options Btn Was Pressed")
	$MenuGroup.visible = false	
	$OptionsGroup.visible = true
	pass

func _on_done_btn_pressed() -> void:
	print("Done Btn Was Pressed")
	$OptionsGroup.visible = false
	$MenuGroup.visible = true	
	pass

func _on_menu_exit_btn_pressed() -> void:
	print("Exit Btn Was Pressed")
	get_tree().quit()
	pass

func _on_music_scroll_bar_value_changed(value: float) -> void:
	audio_player.volume_db = value
	save_volume(value)
	pass

func save_volume(value: float) -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "volume_db", value)
	config.save("user://settings.cfg")

func load_volume() -> float:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		return config.get_value("audio", "volume_db", -20.0) 
	return -20.0
