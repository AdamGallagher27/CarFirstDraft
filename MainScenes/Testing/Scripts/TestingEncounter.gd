extends Node2D

var encounter: Dictionary

# enstantiate with start
var current_node_id = "start"

# not bother writing the read code ATM so im mocking the response
# more features will need to be added to this strucutre including charachter name saying each line (Enables interuption by ADW)
# also individual requirements for charachter lines (these will need fall backs / really good testing)
func get_encounter_json() -> Dictionary: 
	return {
		"requirements": {
			"min_reputation": 20,
			"max_reputation": 100,
			"requiredStoryFlags": ["metAtPark"],
			"blockedByFlags": ["confessionHappened"]
		},
		"dialogue": [
			{
				"id": "start",
				"characterLine": "Oh, hey! I didn't expect to see you here. Did you come for the festival?",
				"responses": [
					{
						"text": "Yeah! I heard it’s amazing.",
						"effect": {
							"reputationChange": {
								"town_status": 5,
								"NPC02": 10
							}
						},
						"next": "talk_about_festival"
					},
					{
						"text": "Not really, just passing by.",
						"effect": {
							"reputationChange": {
								"town_status": 0,
								"NPC02": -5
							}
						},
						"next": "awkward"
					},
					{
						"text": "Fuck off",
						"effect": {
							"reputationChange": {
								"town_status": -10,
								"NPC02": -15
							},
							"setFlags": ["toldThemToFuckOff"]
						},
						"next": "negative_reply"
					}
				]
			},
			{
				"id": "talk_about_festival",
				"characterLine": "Its amazing! The food stalls are my favorite. Have you tried the kebab yet?",
				"responses": [
					{
						"text": "Not yet, want to grab some together?",
						"effect": {
							"startQuest": "fetchKebabQuest",
							"reputationChange": {
								"town_status": 5,
								"NPC02": 10
							}
						},
						"next": "accept_invite"
					},
					{
						"text": "I’m allergic to kebabs, sadly.",
						"effect": {
							"reputationChange": {
								"town_status": 0,
								"NPC02": 0
							}
						},
						"next": "sympathy"
					}
				]
			},
			{
				"id": "awkward",
				"characterLine": "Oh… well, it's still nice to see you. Do you want to hang out for a bit?",
				"responses": [
					{
						"text": "Sure, I'd love that.",
						"effect": {
							"reputationChange": {
								"town_status": 3,
								"NPC02": 5
							}
						},
						"next": "accept_invite"
					},
					{
						"text": "Maybe another time.",
						"effect": {
							"reputationChange": {
								"town_status": 0,
								"NPC02": -5
							}
						},
						"next": "rejected"
					}
				]
			},
			{
				"id": "negative_reply",
				"characterLine": "No you fuck off",
				"responses": [
					{
						"text": "I mean it. You’re a prick.",
						"effect": {
							"reputationChange": {
								"town_status": -15,
								"NPC02": -20
							},
							"setFlags": ["deepHatredFormed"]
						},
						"next": "deep_hatred"
					},
					{
						"text": "Haha, just messing!",
						"effect": {
							"reputationChange": {
								"town_status": -2,
								"NPC02": 2
							}
						},
						"next": "playful"
					}
				]
			},
			{
				"id": "accept_invite",
				"characterLine": "Awesome! Let’s go check out the stalls together. This is going to be fun!",
				"responses": []
			},
			{
				"id": "sympathy",
				"characterLine": "Oh no, that’s too bad. We’ll find something else then!",
				"responses": [
					{
						"text": "Sounds good, lead the way!",
						"effect": {
							"reputationChange": {
								"town_status": 3,
								"NPC02": 5
							}
						},
						"next": "accept_invite"
					}
				]
			},
			{
				"id": "rejected",
				"characterLine": "Oh... okay. Maybe next time.",
				"responses": []
			},
			{
				"id": "deep_hatred",
				"characterLine": "Your so sound.",
				"responses": []
			},
			{
				"id": "playful",
				"characterLine": "Haha, you’re such a prick! But I’ll take it.",
				"responses": [
					{
						"text": "Let’s grab some pints!",
						"effect": {
							"reputationChange": {
								"town_status": 5,
								"NPC02": 10
							}
						},
						"next": "accept_invite"
					}
				]
			}
		]
	}

# also not bothered writing this JSON script 
# (in future will read this and check requirments probably better to do this in the overworld scene before instantiating this scene)
func check_requirments(encounter) -> bool: 
	return true
	
func _on_response_pressed(response_data: Dictionary) -> void:
	if response_data.has("effect"):
#		Write JSON utility 
		print("apply effect function")
	
	if response_data.has("next"):
		show_dialogue_node(response_data["next"])
	else:
		print("End of conversation.")

	
func get_node_data(node_id: String) -> Dictionary:
	if not encounter.has("dialogue"):
		return {}

	var dialogue_array = encounter["dialogue"]
	for node in dialogue_array:
		if node.get("id", "") == node_id:
			return node

	print("Warning: Node with ID '%s' not found." % node_id)
	return {}


func show_dialogue_node(node_id: String):
	var node = get_node_data(node_id)
	
	if not node.has("characterLine"):
		return {}
	
#	name has to be added to json which enables multiple people to be in encounter
	var npc_name = $DialogueUI/DialogueBox/CharachterName
	npc_name.text = "NPC_NAME_FILLER"
	
	var charachter_line = $DialogueUI/DialogueBox/CharacterLine
	charachter_line.text = node["characterLine"]
	var responses = node.get("responses", [])
	
	var container = $DialogueUI/DialogueBox/ResponsesContainer
	for child in container.get_children():
		child.queue_free()
	
	for response_option in responses:
		var btn = Button.new()
		btn.text = response_option["text"]
		btn.connect("pressed", Callable(self, "_on_response_pressed").bind(response_option))
		container.add_child(btn)


func _ready() -> void:
	encounter = get_encounter_json()
	if encounter && check_requirments(encounter):
		show_dialogue_node('start')
