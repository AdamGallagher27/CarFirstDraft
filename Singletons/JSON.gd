extends Node

func read_data(directory):
	var file = FileAccess.open(directory, FileAccess.READ)
	if not file:
		push_error("Failed to open quests file for reading.")
		return

	# Read the content of the file
	var json_text = file.get_as_text()
	file.close()
	
	# Parse the JSON string
	var data = JSON.parse_string(json_text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON structure in quests file.")
		return

	return data

func save_data(directory, data):
	var save_file = FileAccess.open(directory, FileAccess.WRITE)
	if not save_file:
		push_error("Failed to open quests file for writing.")
		return
	
	save_file.store_string(JSON.stringify(data, "\t"))
	save_file.close()
	print("Quest has begun.")
