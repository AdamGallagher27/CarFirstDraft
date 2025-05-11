🧠 Story Flags System Documentation
This file tracks important events or choices the player has triggered in the story. These flags influence dialogue, quests, and branching narratives.

📦 Structure Overview
Each key is a unique story event ID, with a boolean value (true or false).

{
  "bigRevealHappened": false,
  "confessionHappened": false,
  "deepHatredFormed": false,
  "gaveGift": false,
  "hasHadInteraction0": false,
  "metAtPark": false,
  "specialBondFormed": false,
  "toldThemToFuckOff": false
}
Key = the name of the event

Value = whether the event has occurred (true) or not (false)

🧾 Usage
These flags are used in requirements to gate access to dialogue, quests, or scenes.

Example: Dialogue Requirement
"requirements": {
  "requiredStoryFlags": ["metAtPark"],
  "blockedByFlags": ["confessionHappened"]
}
Example: Setting a Flag
You set a flag in a dialogue response's effect:

"effect": {
  "setFlags": ["toldThemToFuckOff"]
}
