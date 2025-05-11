🕒 Game Time System Documentation
This script manages in-game time progression, tracking the time of day, current day, and emitting signals for game logic like UI updates or ending the game.
This is also used in correlation with the NPC charachters, there schedule is scoped within each npc instance and when time moves their location and dialog updates accordingly.

📦 Structure Overview
The time system uses:

An enum to represent the time of day

A counter for the current day

Constants and signals to manage max days and events

enum TimeOfDay { MORNING, MIDDAY, EVENING }
var current_time_of_day: TimeOfDay = TimeOfDay.MORNING
var current_day: int = 1
const MAX_DAYS = 10

🔔 Signals
time_changed
Emitted every time the clock advances (used for UI updates, scheduling events, etc.).

game_over
Emitted once the player reaches the max number of days allowed (used to trigger end game logic or transitions).

⏩ Time Progression
Use advance_time() to move forward in time.

func advance_time():
Flow:
Morning → Midday

Midday → Evening

Evening → Morning (next day)

When a day ends:
current_day is incremented

If it exceeds MAX_DAYS, cap the value and emit game_over
MAX_DAYS is an arbitrary int.
