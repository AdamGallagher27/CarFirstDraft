extends Node3D

const GROUND_LEVEL: float = -0.309

# schedule exxample 
# would rather a better positon system than usings vectors 
# if we use vectores means we have the entire map in once scene and "fake" the transitions 
# could be good for optimisation specially with fast travel but not sure need to think about it
@export var schedule: Dictionary = {
	1: {  # Day 1
		"MORNING": { "position": Vector3(0.175, GROUND_LEVEL, -2.572), "event_name": "first_encounter" },
		"MIDDAY": { "position": Vector3(0.25, GROUND_LEVEL, -2.3), "event_name": "second_encounter" },
		"EVENING": { "position": Vector3(0.45, GROUND_LEVEL, -2.1), "event_name": "first_encounter" }
	},
	2: {  # Day 2
		"MORNING": { "position": Vector3(0.1, GROUND_LEVEL, -2.4), "event_name": "fourth_encounter" },
		"MIDDAY": { "position": Vector3(0.35, GROUND_LEVEL, -2.5), "event_name": "sixth_encounter" },
		"EVENING": { "position": Vector3(0.4, GROUND_LEVEL, -2.3), "event_name": "seventh_encounter" }
	},
	3: {  # Day 3
		"MORNING": { "position": Vector3(0.3, GROUND_LEVEL, -2.0), "event_name": "fourth_encounter" },
		"MIDDAY": { "position": Vector3(0.2, GROUND_LEVEL, -2.4), "event_name": "fifth_encounter" },
		"EVENING": { "position": Vector3(0.45, GROUND_LEVEL, -2.25), "event_name": "fifth_enounter" }
	},
	4: {  # Day 4
		"MORNING": { "position": Vector3(0.15, GROUND_LEVEL, -2.3), "event_name": "first_encounter" },
		"MIDDAY": { "position": Vector3(0.4, GROUND_LEVEL, -2.5), "event_name": "elenth_encounter" },
		"EVENING": { "position": Vector3(0.35, GROUND_LEVEL, -2.1), "event_name": "seventh_encounter" }
	},
	5: {  # Day 5
		"MORNING": { "position": Vector3(0.25, GROUND_LEVEL, -2.0), "event_name": "fourth_encounter" },
		"MIDDAY": { "position": Vector3(0.3, GROUND_LEVEL, -2.2), "event_name": "eighth_encounter" },
		"EVENING": { "position": Vector3(0.5, GROUND_LEVEL, -2.4), "event_name": "fifth_enounter" }
	},
	6: {  # Day 6
		"MORNING": { "position": Vector3(0.35, GROUND_LEVEL, -2.1), "event_name": "first_encounter" },
		"MIDDAY": { "position": Vector3(0.4, GROUND_LEVEL, -2.3), "event_name": "sixth_encounter" },
		"EVENING": { "position": Vector3(0.5, GROUND_LEVEL, -2.0), "event_name": "nineth_encounter" }
	},
	7: {  # Day 7
		"MORNING": { "position": Vector3(0.2, GROUND_LEVEL, -2.4), "event_name": "fourth_encounter" },
		"MIDDAY": { "position": Vector3(0.25, GROUND_LEVEL, -2.3), "event_name": "tenth_encounter" },
		"EVENING": { "position": Vector3(0.45, GROUND_LEVEL, -2.5), "event_name": "eighth_encounter" }
	},
	8: {  # Day 8
		"MORNING": { "position": Vector3(0.3, GROUND_LEVEL, -2.2), "event_name": "first_encounter" },
		"MIDDAY": { "position": Vector3(0.45, GROUND_LEVEL, -2.1), "event_name": "elenth_encounter" },
		"EVENING": { "position": Vector3(0.35, GROUND_LEVEL, -2.3), "event_name": "fifth_enounter" }
	},
	9: {  # Day 9
		"MORNING": { "position": Vector3(0.15, GROUND_LEVEL, -2.5), "event_name": "fourth_encounter" },
		"MIDDAY": { "position": Vector3(0.3, GROUND_LEVEL, -2.4), "event_name": "fifth_encounter" },
		"EVENING": { "position": Vector3(0.45, GROUND_LEVEL, -2.2), "event_name": "seventh_encounter" }
	},
	10: {  # Day 10
		"MORNING": { "position": Vector3(0.25, GROUND_LEVEL, -2.1), "event_name": "first_encounter" },
		"MIDDAY": { "position": Vector3(0.35, GROUND_LEVEL, -2.3), "event_name": "eighth_encounter" },
		"EVENING": { "position": Vector3(0.4, GROUND_LEVEL, -2.2), "event_name": "nineth_encounter" }
	}
}


# Stores the actual dialogues
@export var dialogues: Dictionary = {
	"first_encounter": {
		"small": "Whats the story bud?"  # Main dialogue
	},
	"second_encounter": {
		"main": "testNPCEncounter0",  # Small dialogue
	},
	"third_encounter": {
		"main": "01"  # Main dialogue
	},
	"fourth_encounter": {
		"small": "Did you hear the latest rumors?"  # Small dialogue
	},
	"fifth_encounter": {
		"small": "Good to see you! How's everything going?"  # Small dialogue
	},
	"sixth_encounter": {
		"main": "02"  # Main dialogue
	},
	"seventh_encounter": {
		"main": "03"  # Main dialogue
	},
	"eighth_encounter": {
		"main": "04"  # Main dialogue
	},
	"nineth_encounter": {
		"small": "All is quiet tonight. Rest easy."  # Small dialogue
	},
	"tenth_encounter": {
		"main": "05"  # Main dialogue
	},
	"elevnth_encounter": {
		"small": "Oh, it's you again. Back for more adventures?"  # Small dialogue
	}
}

# Tracks which events are DONE (so main conversations don't repeat)
var completed_events: Dictionary = {}

# Current active event (set by schedule)
var current_event_name: String = ""
var has_main_dialogue: bool = false

func _ready():
	update_npc_state()
	GameManager.time_changed.connect(update_npc_state)

func update_npc_state():
	var day = GameManager.current_day
	var time_of_day_enum = GameManager.current_time_of_day
	var time_of_day_name = GameManager.TimeOfDay.keys()[time_of_day_enum]  # "MORNING" etc.

	if schedule.has(day) and schedule[day].has(time_of_day_name):
		var data = schedule[day][time_of_day_name]
		print(data)
		
		# Move NPC
		if data.has("position"):
			global_transform.origin = data["position"]
			visible = true

		# Set current event
		if data.has("event_name"):
			current_event_name = data["event_name"]
			has_main_dialogue = true
		else:
			current_event_name = ""
			has_main_dialogue = false
	else:
		visible = false
		current_event_name = ""
		has_main_dialogue = false


# check if the player is close enough to have a converstaion / unsets self when to far away
func _on_area_3d_body_entered(player: Node3D) -> void:
	if player.name == "Player":
		player.current_npc = $"."


func _on_area_3d_body_exited(player: Node3D) -> void:
	if player.name == "Player":
		player.current_npc = null


func interact():
	if current_event_name == "":
		print("This NPC has nothing to say right now.")
		return

	var event_data = dialogues.get(current_event_name, null)
	if event_data == null:
		print("No dialogue data found for event: ", current_event_name)
		return

	var main_exists = event_data.has("main")

	if has_main_dialogue and main_exists and not completed_events.get(current_event_name, false):
		
#		IF the npc has a main scene open conversations scene retrieve encounter data using main id in dialouges object
		if event_data.has("main"):
			print(" 💬 MAIN (go to main scene with main id): ", event_data.main)
			#var scene_path = event_data["main_scene"]
			#var scene = load(scene_path)
			#if scene:
				#var scene_instance = scene.instantiate()
				#get_tree().current_scene.add_child(scene_instance)
				#print("💬 Loaded main dialogue scene: ", scene_path)
			#else:
				#print("Failed to load scene: ", scene_path)
		#else:
			#print("💬 MAIN: ", event_data.get("main", ""))

		completed_events[current_event_name] = true 
	else:
		# Trigger small talk
		if event_data.has("small"):
			print("💬 SMALL: ", event_data.get("small", ""))
		else:
			print("This NPC has nothing to say (no small talk either).")


#schedule: Holds where the NPC should be and what event should be triggered based on the time of day and day of the game.
#
#dialogues: Contains both main dialogue and small talk. If an NPC has no "main" dialogue, it will only offer "small" dialogue.
#
#completed_events: A record of events that the player has completed (prevents the same main conversation from being triggered twice).
#
#update_npc_state(): Checks the schedule based on the current game day and time. It then updates the NPC's position and decides whether it should have a main or small dialogue.
#
#interact(): Handles what happens when the player interacts with the NPC. It decides whether to show main dialogue or small talk based on the NPC's state.

#current_event_name: This is the event that determines which dialogue to trigger.
#
#event_data: The actual dialogue data for the event (either "main" or "small").
#
#Checking for main_scene: If the NPC is supposed to load a scene (e.g., a cutscene or a quest-giving screen), it checks for "main_scene" and loads that instead of displaying text.
#
#Dialogue Display: If there’s no scene, it displays the main text. If the main conversation has been completed, it falls back to small talk.
#
#completed_events[current_event_name]: Marks the event as completed after the interaction to prevent the main dialogue from triggering again.
