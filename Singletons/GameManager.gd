extends Node

signal time_changed
signal game_over  # Signal to trigger when game hits max days

enum TimeOfDay { MORNING, MIDDAY, EVENING }

var current_time_of_day: TimeOfDay = TimeOfDay.MORNING
var current_day: int = 1
const MAX_DAYS = 10


func _ready() -> void:
	print("Day: ", current_day, " Time: ", TimeOfDay.keys()[current_time_of_day])

func advance_time():
	if current_time_of_day == TimeOfDay.MORNING:
		current_time_of_day = TimeOfDay.MIDDAY
	elif current_time_of_day == TimeOfDay.MIDDAY:
		current_time_of_day = TimeOfDay.EVENING
	elif current_time_of_day == TimeOfDay.EVENING:
		current_time_of_day = TimeOfDay.MORNING
		current_day += 1  # Move to next day after evening

		if current_day > MAX_DAYS:
			current_day = MAX_DAYS 
			print("Reached max days. Game over!")
			emit_signal("game_over")
			return

	print("Day: ", current_day, " Time: ", TimeOfDay.keys()[current_time_of_day])
	emit_signal("time_changed")
