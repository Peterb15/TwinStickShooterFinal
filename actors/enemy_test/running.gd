extends State

@export var chase_speed : float = 50.0
var target : CharacterBody2D
var sense_range : Area2D
@onready var chasing_state : State = get_parent().get_node("Running")
@onready var dodge_state : State = get_parent().get_node("Dodge")
@onready var isRunning = get_parent().get_node("Dodge").isRunning


func initialize():
		sense_range = body.get_node("SenseRange")

# It will just chase the player for now
func process_state(delta):
	if(isRunning == false):
		isRunning = true
	var incoming_fire = sense_range.get_overlapping_areas()
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	if (not incoming_fire.is_empty()):
		for i in incoming_fire.size():
			if incoming_fire[i].is_in_group("projectile"):
				print("YO")	
				dodge_state.target = incoming_fire[i]
				change_state.emit(dodge_state)
				
		#math to sort oout dir and animation
	var angle = rad_to_deg(body.velocity.angle()) + 180
	if(body.velocity.length() < 10):
		print("OOP")
		#$AnimationPlayer.play("idle_front")
	else:
		if(angle > 135 and angle < 225):
			get_parent().get_parent().get_node("AnimationPlayer").play("Moving_Right")
		elif (angle > 225 and angle < 315):
			print("Fix walk up")
			#$AnimationPlayer.play("walk_front")
		elif (angle > 315 or angle < 45):
			get_parent().get_parent().get_node("AnimationPlayer").play("Moving_Left")
		elif (angle > 45 and angle < 135):
			#$AnimationPlayer.play("walk_up")
			print("Fix walk up")

				
