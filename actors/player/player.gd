extends CharacterBody2D
class_name Player

@export var projectile_scene: Resource
@export var teleport_scene: Resource
@export var lightning_scene: Resource
@export var move_speed: float = 200.0
@export var hp = 5

# Toggle variable to switch between teleport and projectile
var use_teleport: bool = false
var useAnimation = 0
func _ready():
	lightning_scene = preload("res://actors/lightning/lightning.tscn")# Replace with the correct path
	start_HpDisplay()

func hit(damage_number: int):
		hp -= damage_number
		update_HpDisplay()
		get_node("HpDisplay").add_text
		if(hp == 0):
			#queue_free()
			get_tree().change_scene_to_file("res://Defeat/defeat.tscn")
			pass # Rep
			
			
func start_HpDisplay():
	var rich_text_label = $HpDisplay
	rich_text_label.add_text("HP: " + str(hp))

# Function to update the variable and display it in RichTextLabel
func update_HpDisplay():
	var HpDisplay = $HpDisplay
	HpDisplay.clear()
	HpDisplay.add_text("HP: " + str(hp))
	
			

func _input(event):

	if (event is InputEventMouseButton):
		# Only shoot on left click pressed down
		if (event.button_index == 1 and event.is_pressed()):
			useAnimation = 1
			var new_projectile = projectile_scene.instantiate()
			get_parent().add_child(new_projectile)
			var projectile_forward = Vector2.from_angle(get_local_mouse_position().angle())
			new_projectile.fire(projectile_forward, 1000.0)
			new_projectile.position = $ProjectileRefPoint.global_position
		if (event.button_index == 2 and event.is_pressed()): #ADD A TIMER
			useAnimation = 2
			var new_teleport = teleport_scene.instantiate()
			get_parent().add_child(new_teleport)
			print("TELE")
			var teleport_forward = get_global_mouse_position()
			new_teleport.location(teleport_forward)
			new_teleport.position = $TeleportRefPoint.global_position
			$AnimationPlayer.play("teleport")
	elif event is InputEventKey:
		if event.keycode == KEY_Q and event.pressed:
			useAnimation = 3
			var new_lightning = lightning_scene.instantiate()  # Correct instantiation
			get_parent().add_child(new_lightning)
			print("Light")
		
		# Calculate the direction to fire the lightning
			var lightning_forward = (get_global_mouse_position() - $LightningRefPoint.global_position).normalized()
		
		# Call the fire method and set the position	
			new_lightning.fire(lightning_forward, 1000.0)
			new_lightning.position = $LightningRefPoint.global_position


func _physics_process(delta):
	
	#look_at(get_viewport().get_mouse_position())
	if(useAnimation == 0):
		velocity = Input.get_vector("move_left", \
			"move_right", \
			"move_up", \
			"move_down") * move_speed
		move_and_slide()
	
	#math to sort oout dir and animation
	var angle = rad_to_deg(velocity.angle()) + 180
	if(useAnimation == 0):
		if(velocity.length() < 10):
			$AnimationPlayer.play("idle_front")
			#$AnimationPlayer.play("lightning")
		else:
			if(angle > 135 and angle < 225):
				$AnimationPlayer.play("walk_right")
			elif (angle > 225 and angle < 315):
				$AnimationPlayer.play("walk_front")
			elif (angle > 315 or angle < 45):
				$AnimationPlayer.play("walk_left")
			elif (angle > 45 and angle < 135):
				$AnimationPlayer.play("walk_up")
	elif(useAnimation == 1):
		$AnimationPlayer.stop
		$AnimationPlayer.play("bubble")
	elif(useAnimation == 2):
		$AnimationPlayer.stop
		$AnimationPlayer.play("teleport")
	elif(useAnimation == 3):
		$AnimationPlayer.stop
		$AnimationPlayer.play("lightning")

	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(useAnimation == 1 || useAnimation == 2 || useAnimation == 3):
		useAnimation = 0
	pass # Replace with function body.
