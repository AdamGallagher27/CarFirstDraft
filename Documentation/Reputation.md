📈 Reputation System Documentation
This system tracks how the player is perceived by different NPCs and the town as a whole. Reputation values affect which dialogues, quests, and events are available.

📦 Structure Overview
Each top-level key represents an entity whose opinion of the player is tracked.

{
  "NPC01": 0.0,
  "NPC02": 0.0,
  "NPC03": 0.0,
  "town_status": 0.0
}
Keys like NPC01, NPC02, etc., refer to individual named characters.

town_status represents the general reputation of the player across the entire community.

🧮 Values
Each reputation value is a floating-point number (default is 0.0).

Positive values = good standing or favor

Negative values = bad standing or distrust

Zero = neutral or unknown


✅ Usage
These values are updated by dialogue effect objects:

"effect": {
  "reputationChange": {
	"NPC02": 10,
	"town_status": 5
  }
}
You can also read these values to check if a minimum or maximum threshold has been met in:

requirements for conversations

requirements for quests
