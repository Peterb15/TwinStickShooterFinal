extends State

@export var chase_speed : float = 200.0

@onready var running_state : State = get_parent().get_node("Running")
@onready var stalk_state : State = get_parent().get_node("Stalk")
@onready var dodgeReady : bool = true
@onready var clearVector: Vector2 = Vector2(0,0)
@onready var dodge_move: float = 500
@export var isRunning: bool = false
var target : Area2D
var variety = 0
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var dodge_sfx: AudioStreamPlayer2D = $"../../dodgeSFX"

# It will just chase the player for now
func _ready() -> void:
	animation_player.play("Moving_Left")
func nowRunning():
	isRunning = true
func process_state(delta):
	if dodgeReady == true:
		dodge_sfx.play()
		var direction = (target.position - body.position).normalized()

		# Calculate the direction from the body to the target

			
			

		# Get the perpendicular direction by swapping x and y, and negating one component
		var perp_direction = Vector2(-direction.y, direction.x)

		# Adjust velocity based on the perpendicular direction towards the target
		#body.collision_layer = 8
		if variety == 0:
			body.velocity = perp_direction * dodge_move
			variety = 1
		elif variety == 1:
			body.velocity = direction * dodge_move
			variety = 2
		elif variety == 2:
			body.velocity = -perp_direction * dodge_move
			variety = 3
		elif variety == 3:
			body.velocity = -direction * dodge_move
			variety = 0

		# Start the dodge timer
		$DodgeTimer.start()
		get_parent().get_parent().collision_layer = 10
		$CooldownTimer.start()
		dodgeReady = false
	
	# Use move_and_slide to handle velocity and collisions
	body.move_and_slide()

func _on_dodge_timer_timeout() -> void:
	body.floor_stop_on_slope
	body.velocity = Vector2.ZERO  # Reset velocity to stop movement


	pass # Replace with function body.

	


func _on_cooldown_timer_timeout() -> void:
	if isRunning == true:
		change_state.emit(running_state)
	else:
		change_state.emit(stalk_state)
	get_parent().get_parent().collision_layer = 2
	dodgeReady = true
	pass # Replace with function body.
