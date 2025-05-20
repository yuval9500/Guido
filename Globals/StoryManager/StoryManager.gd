extends Node

@export var stateIndex = 1

# Load the story file and return its lines
func loadStory(file_name: String) -> Array:
	var file_path = "res://Story/" + file_name + ".txt"
	var lines = []

	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file == null:
		print("Error opening file: " + file_path)
	else:
		while not file.eof_reached():
			var line = file.get_line()
			lines.append(line)
		file.close()

	return lines

# Parse the lines into names, dialogues, and optional actions
func ParseLines(lines: Array) -> Array:
	var names = []
	var dialogues = []
	var actions = []

	for line in lines:
		var parts = line.split("$")
		if parts.size() >= 2:
			names.append(parts[0].strip_edges())
			dialogues.append(parts[1].strip_edges())

			# Handle optional third part (command/action)
			if parts.size() >= 3:
				actions.append(parts[2].strip_edges())
			else:
				actions.append("")  # No action provided
		else:
			print("Invalid line format: " + line)

	return [names, dialogues, actions]
