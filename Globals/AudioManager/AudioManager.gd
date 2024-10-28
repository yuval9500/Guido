extends Node

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
