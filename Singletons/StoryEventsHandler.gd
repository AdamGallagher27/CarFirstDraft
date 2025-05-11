extends Node

const DATABASE_DIR := "res://database/"
const STORY_EVENTS_FILE := "StoryEvents.json"

# Change the story event flag (for StoryEvents.json file)
func change_story_event(id: String, value: bool) -> void:
	var file = FileAccess.open(DATABASE_DIR + STORY_EVENTS_FILE, FileAccess.READ)
	if not file:
		push_error("Failed to open story events file for reading.")
		return

	var json_text = file.get_as_text()
	file.close()
	
	# Parse the JSON string
	var data = JSON.parse_string(json_text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON structure in story events file.")
		return

	# Check if the ID exists
	if not data.has(id):
		push_error("Story Event ID '%s' not found in story events file." % id)
		return

	# Change the story event value (which is a boolean)
	data[id] = value

	print(data[id])

	# Save the file back with the updated story event
	var save_file = FileAccess.open(DATABASE_DIR + STORY_EVENTS_FILE, FileAccess.WRITE)
	if not save_file:
		push_error("Failed to open story events file for writing.")
		return

	save_file.store_string(JSON.stringify(data, "\t"))  # Pretty print with tabs
	save_file.close()

	print("Story Event '%s' updated to %s." % [id, str(value)])

func get_story_event_status() -> Dictionary:
	# Open the StoryEvents.json file for reading
	var file = FileAccess.open(DATABASE_DIR + STORY_EVENTS_FILE, FileAccess.READ)
	if not file:
		push_error("Failed to open story events file for reading.")
		return {}

	# Read the content of the file
	var json_text = file.get_as_text()
	file.close()
	
	# Parse the JSON string
	var data = JSON.parse_string(json_text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON structure in story events file.")
		return {}

	# Return the status of all story events
	return data
