🧭 Quest System Documentation
This system tracks active, incomplete, and completed quests. Quests can be tied to dialogue effects and reward the player with changes in reputation or story flags.

📦 Structure Overview
Each top-level key (e.g. fetchKebabQuest) is a unique quest ID.

Each quest contains:

TITLE: A name for the quest.
DESCRIPTION: What the player is being asked to do.
HASBEGUN: Boolean – has the quest started?
ISCOMPLETE: Boolean – is the quest finished?
STARTDATE: When the quest begins (this follows a unique format days are represented as numbers and time is either MORNING, MIDDAY, EVENING so time is stored as 1_MORNING format). 
		   Also worth noting max in game days can be saved in the GameManagar singleton.
COMPLETEBY: Deadline for quest completion (uses same format as above).
REQUIREMENTS: Conditions to start the quest.
REWARD: What the player gets if they finish the quest.

📋 title & description
Basic info shown in the quest log.

"title": "GetKebab",
"description": "Grab a kebab for your date"

🔄 State Flags
"hasBegun": false,
"isComplete": false
hasBegun: When true, the quest is considered active.

isComplete: When true, the quest is marked finished (can still remain in log if needed).

🕒 Time Constraints
"startDate": "1_MORNING",
"completeBy": "3_MIDDAY"

STARTDATE: When the quest starts (e.g., day and time period).
COMPLETEBY: Deadline for finishing the quest.

🧾 requirements
These must be met to start the quest.

"requirements": {
  "requiredFlags": ["metAtPark"]
}
REQUIREDFLAGS: Flags from StoryEvents.JSON that must be true for the quest to begin.


🎁 reward
What happens when the quest is completed.

"reward": {
  "reputationChange": {
	"town_status": 3,
	"NPC02": 5
  },
  "unlockEvent": "specialDinner"
}
REPUTATIONCHANGE: Boosts for the town and specific NPCs or the town as a whole.
UNLOCKEVENT: A story flag or event unlocked by completing the quest.

✅ Example Quest JSON
"fetchKebabQuest": {
  "title": "GetKebab",
  "description": "Grab a kebab for your date",
  "hasBegun": false,
  "isComplete": false,
  "startDate": "1_MORNING",
  "completeBy": "3_MIDDAY",
  "requirements": {
	"requiredFlags": ["metAtPark"]
  },
  "reward": {
	"reputationChange": {
	  "town_status": 3,
	  "NPC02": 5
	},
	"unlockEvent": "specialDinner"
  }
}
