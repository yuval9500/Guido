extends Node

@export var stateIndex = 1

func loadStory(file_name: String) -> Array:
	var file_path = "res://Story/" + file_name + ".txt"
	var lines = []
	
	# Use FileAccess to open the file directly
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file == null:
		print("Error opening file: " + file_path)
	else:
		while not file.eof_reached():
			var line = file.get_line()
			lines.append(line)
		file.close()

	return lines
	
func ParseLines(lines: Array) -> Array:
	var names = []
	var dialogues = []
	
	for line in lines:
		var parts = line.split("$")
		if parts.size() == 2:
			names.append(parts[0].strip_edges()) 
			dialogues.append(parts[1].strip_edges())
		else:
			print("Invalid line format: " + line)
	
	return [names, dialogues]
