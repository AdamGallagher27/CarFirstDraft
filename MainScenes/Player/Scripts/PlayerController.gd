extends CharacterBody3D

@export var speed: float = 0.5
@export var acceleration: float = 1.0

@export var map_menu: Panel

var current_npc: CharacterBody3D = null 


func _ready() -> void:
	if map_menu:
		map_menu.hide()

func _physics_process(delta):
	var input_vector = Vector3.ZERO
	#print("Player position: ", global_transform.origin)
	if Input.is_action_pressed("up"):
		input_vector.z -= 1
	if Input.is_action_pressed("down"):
		input_vector.z += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_vector.x += 1
	
		# this is for debuging and testing this pushes time forward (morning, midday, evening until next morning)
		# this was cause the npc charachters to reset with new dialog for the new day or time
	if Input.is_action_just_pressed("move_time_forward"):
		GameManager.advance_time()
		
		# this is for testing the story event updating
		#StoryEventsHandler.change_story_event("gaveGift", true)
		
		# this is for testing the reputation updating
		#ReputationHandler.change_reputation("town_status", 10)
	
	if Input.is_action_just_pressed("open_map"):
		if map_menu.visible:
			map_menu.hide()
		else:
			map_menu.show()

	
	if input_vector != Vector3.ZERO:
		input_vector = input_vector.normalized()
		velocity.x = input_vector.x * speed
		velocity.z = input_vector.z * speed
		move_and_slide()
		
	if current_npc and Input.is_action_just_pressed("interact"):
		interact_with_npc(current_npc)

func interact_with_npc(npc: Node3D):
	if npc.has_method("interact"):
		npc.interact()
