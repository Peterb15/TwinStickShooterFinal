extends State

var sense_range : Area2D
@onready var chasing_state : State = get_parent().get_node("Running")
@onready var dodge_state : State = get_parent().get_node("Dodge")

func initialize():
		sense_range = body.get_node("SenseRange")

# Initialize our required values
func process_state(delta):
	# Get the list of potential targets. There should only be one
	# If there is one, go after it
	# Make sure to limit 
	var potential_targets = sense_range.get_overlapping_bodies();
	var incoming_fire = sense_range.get_overlapping_areas()
	if (not incoming_fire.is_empty()):
		for i in incoming_fire.size():
			if incoming_fire[i].is_in_group("projectile"):
				print("YO")	
				dodge_state.target = incoming_fire[i]
				change_state.emit(dodge_state)
	if (not potential_targets.is_empty()):
		print(potential_targets[0])
		chasing_state.target = potential_targets[0]
		change_state.emit(chasing_state)
