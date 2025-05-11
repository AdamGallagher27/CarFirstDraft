🗣 Conversation System Documentation
This system lets you create branching NPC conversations in the game using JSON.

🤔 Future work?
Currently no start combat or start minigame or start cutscene these should be easy to add in later 
(jsut another object with an id to instantiate a new scene and read another json file)
No individual dialouge requirements property just overall conversation requirements but again easy to add it
can add requirments property to each dialogue object and use same methods in route of conversation object.

📦 Structure Overview
Each top-level key (e.g. testNPCEncounter0) is a unique conversation ID tied to a specific NPC or event.

Each conversation contains:
REQUIREMENTS: Conditions that must be true to start the conversation.
DIALOGUE: An array of dialogue nodes with character lines and player response options.

🧾 requirements
These are the conditions that must be met to allow the conversation to start.

MIN_REPUTATION: minimum combined charachter and town reputation to have conversation (individual charachter and overall town reputation stored in Reputation.JSON).
MAX_REPUTATION: Maximum cobined charachter and town reputation to have conversation.
REQUIREDSTORYFLAGS: These are the required story moments that must be enabled to have conversation (Stored with unique id property name and boolean value in StoryEvents.JSON).
BLOCKEDBYFLAGS: Same as above but for blocked events in StoryEvents.JSON (if this event has happened dont allow converstaion).

"requirements": {
  "min_Reputation": 20,
  "max_Reputation": 100,
  "requiredStoryFlags": ["metAtPark"],
  "blockedByFlags": ["confessionHappened"]
}


💬 dialogue
An array of dialogue nodes. Each node has an ID, what the character says, and response options for the player.

ID: Unique pointer for each dialouge node (conversation starting point always has "start" as value)
CHARACHTERLINE: This is what the NPC will say for each beat in the conversation.
RESPONSES: This is an array of response options based on the CHARACHTERLINE property (if empty its the end of conversation).

{
  "id": "start",
  "characterLine": "Oh, hey! I didn't expect to see you here. Did you come for the festival?",
  "responses": [...]
}

🙋 responses
Each response in the RESPONSES array is a player response based off the given CHARACHTERLINE. It can change the game state and lead to another node.

TEXT: what the player says in response to the npc.
EFFECT: this is the consequences of what the player says (reputation change, start quest or date etc.).
NEXT: Pointer to the next beat in the conversations i.e next charachter node id.

{
  "text": "Yeah! I heard it’s amazing.",
  "effect": {
	"reputationChange": {
	  "town_status": 5,
	  "NPC02": 10
	}
  },
  "next": "talk_about_festival"
}

🎯 effect
Used inside a response to update game state (consequences of what the user responds to npc dialogue).

REPUTATIONCHANGE: updates player and town reputation.
SETFLAGS: Adds story flags to the player's progress.
STARTQUEST: Begins a quest by ID.

"effect": {
  "reputationChange": {
	"town_status": 5,
	"NPC02": -10
  },
  "setFlags": ["toldThemToFuckOff"],
  "startQuest": "fetchKebabQuest"
}


✅ Ending a Conversation
A dialogue node with no responses is the end of the conversation.
