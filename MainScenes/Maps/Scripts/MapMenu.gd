extends Panel

@export var player: CharacterBody3D
const FLOOR: float = -0.309

func _on_location_1_gui_input(event: InputEvent) -> void:
	player.global_transform.origin = Vector3(-0.57, FLOOR, -3.04)


func _on_location_2_gui_input(event: InputEvent) -> void:
	player.global_transform.origin = Vector3(0.64, FLOOR, -2.19)


func _on_location_3_gui_input(event: InputEvent) -> void:
	player.global_transform.origin = Vector3(-0.43, FLOOR, -1.76)
