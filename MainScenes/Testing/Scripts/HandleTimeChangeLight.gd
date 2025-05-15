extends DirectionalLight3D


func _ready() -> void:
	GameManager.time_changed.connect(update_light_state)

func update_light_state():
		var time_of_day_enum = GameManager.current_time_of_day
		var time_of_day_name = GameManager.TimeOfDay.keys()[time_of_day_enum]
		
		if time_of_day_name == "MORNING":
			light_energy = 2.0
		
		elif time_of_day_name == "MIDDAY":
			light_energy = 8.0
			
		else:
			light_energy = 0.0
