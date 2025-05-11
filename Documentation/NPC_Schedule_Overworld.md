🧭 NPC Schedule + Dialogue System Documentation
This system manages NPC positioning and interactions based on the in-game time/day from GameManager.

💼 Responsibilities
Moves NPCs based on a predefined schedule and current day time

Assigns event names that control dialogue logic

Allows interaction with main dialogues (once) or small talk


🛠 Exposed Variables
@export var schedule: Dictionary
@export var dialogues: Dictionary

🔁 schedule
Contains NPC positions and triggered events per day and time of day.

Dialouges
These events are stored in this object with a small property or a main property (There is also an option for neither meaning the charchter has nothing to say).
An event can be small which is a short string which is returned to the screen in a speach bubble above the npc charachter
or a main id which point to a full conversation in Encounter.json (in future when this is return a new scene which will opened with the conversation that matches the id)

1: {
  "MORNING": { "position": Vector3(...), "event_name": "first_encounter" },
  ...
}
💬 dialogues
Contains either:

"main" → ID for a scene/dialogue block

"small" → fallback line of text

"first_encounter": {
  "main": "00", 
  "small": "Hey, what's the story bud?"
}
