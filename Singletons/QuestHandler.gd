extends Node

const DATABASE_DIR := "res://database/"
const QUESTS_FILE := "Quests.json"

# start a quest by setting its 'hasBegun' property to true
func start_quest(quest_name: String) -> void:
	var data = Json.read_data(DATABASE_DIR + QUESTS_FILE)

	if not data.has(quest_name):
		push_error("Quest '%s' not found in quests file." % quest_name)
		return

	# set the 'hasBegun' property of the quest to true
	data[quest_name]["hasBegun"] = true

	Json.save_data(DATABASE_DIR + QUESTS_FILE, data)
	# save the updated quest data back into the file
	print("Quest '%s' has begun." % quest_name)

# end a quest by setting its 'isDone' property to true
func end_quest(quest_name: String) -> void:
	var data = Json.read_data(DATABASE_DIR + QUESTS_FILE)

	# Check if the quest exists
	if not data.has(quest_name):
		push_error("Quest '%s' not found in quests file." % quest_name)
		return

	# Set the 'isDone' property of the quest to true
	data[quest_name]["isDone"] = true
	
	Json.save_data(DATABASE_DIR + QUESTS_FILE, data)

# get all quests that are marked as accepted and return them in an array
# (for show active quests page)
func get_accepted_quests() -> Array:
	var accepted_quests = []

	var data = Json.read_data(DATABASE_DIR + QUESTS_FILE)

	# Iterate through all quests and collect those with 'hasBegun' == true
	for quest_name in data.keys():
		var quest = data[quest_name]
		if quest.has("hasBegun") and quest["hasBegun"]:
			accepted_quests.append(quest_name)

	return accepted_quests

#returns quest object from quests.json file
func get_quest_data(quest_id: String) -> Dictionary:
	# Open the quests JSON file for reading
	var data = Json.read_data(DATABASE_DIR + QUESTS_FILE)

	# Check if the quest_id exists in the data
	if not data.has(quest_id):
		push_error("Quest '%s' not found in quests file." % quest_id)

	# Return the quest data for the given quest_id
	return data[quest_id]

#checks that quest matches the requirments to be accepted
func check_quest_requirements(quest_id: String) -> bool:
	# Load the quest data from the JSON file
	var quest = get_quest_data(quest_id)
	if quest == null:
		push_error("Quest not found: %s" % quest_id)
		return false

	# Get the story event status from the StoryEventsHandler
	var story_events_status = StoryEventsHandler.get_story_event_status()

	# Check if required flags are met
	for required_flag in quest["requirements"]["requiredFlags"]:
		if not story_events_status.has(required_flag) or not story_events_status[required_flag]:
			print("Required flag '%s' is not met." % required_flag)
			return false  # Required flag is not met

	# Check if blocked flags are met
	for blocked_flag in quest["requirements"]["blockedFlags"]:
		if story_events_status.has(blocked_flag) and story_events_status[blocked_flag]:
			print("Blocked flag '%s' is met, quest cannot proceed." % blocked_flag)
			return false  # Blocked flag is active

	# If all conditions pass
	print("Quest requirements met.")
	return true
