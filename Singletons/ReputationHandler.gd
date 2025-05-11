extends Node

const DATABASE_DIR := "res://database/"
const REPUTATION_FILE := "Reputation.json"

func change_reputation(id: String, amount: int) -> void:
	var file = FileAccess.open(DATABASE_DIR + REPUTATION_FILE, FileAccess.READ)
	if not file:
		push_error("Failed to open reputation file for reading.")
		return

	var json_text = file.get_as_text()
	file.close()
	

	# Parse the JSON string
	var data = JSON.parse_string(json_text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON structure in reputation file.")
		return

	# Check if the ID exists
	if not data.has(id):
		push_error("Reputation ID '%s' not found in reputation file." % id)
		return

	# Change the reputation value
	data[id] += amount

	# Save the file back with the updated reputation
	var save_file = FileAccess.open(DATABASE_DIR + REPUTATION_FILE, FileAccess.WRITE)
	if not save_file:
		push_error("Failed to open reputation file for writing.")
		return

	save_file.store_string(JSON.stringify(data, "\t"))  # Pretty print with tabs
	save_file.close()

	print("Reputation for '%s' updated by %d. New value: %d" % [id, amount, data[id]])
