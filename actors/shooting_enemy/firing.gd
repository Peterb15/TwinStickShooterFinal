extends State

@export var chase_speed : float = 50.0
var target : CharacterBody2D
@export var enemy_projectile_scene: Resource
var justFired: bool = false
@onready var holstered_state : State = get_parent().get_node("Holstered")

func _ready() -> void:
		enemy_projectile_scene = preload("res://enemy_projectile.tscn")
	
# It will fire at the player
func process_state(delta):
	if justFired == false:
		print(target.position)
		
		var new_projectile = enemy_projectile_scene.instantiate()
		get_parent().add_child(new_projectile)
		
		# Calculate the forward vector of the projectile based on the target's position
		var distance = sqrt(pow(target.position.y, 2) + pow(target.position.x, 2))
		var angle = target.position.y / distance
		var projectile_forward = Vector2.from_angle(angle)
		
				# Set the projectile's initial position 
		new_projectile.position = get_parent().get_parent().get_node("ProjectileRefPoint").global_position
		
		# Fire the projectile in the correct direction
		get_parent().get_parent().get_node("AnimationPlayer").play("Shooting")
		new_projectile.fire((target.position - new_projectile.position).normalized(), target.position, 500)  # pass target position


		
		# Set justFired to true and start the shooting timer
		justFired = true
		get_parent().get_parent().get_node("ShootingTimer").start()

func _on_shooting_timer_timeout() -> void:
	justFired = false
	pass # Replace with function body.
	
	

func _on_sense_range_body_exited(body: Node2D) -> void:
	change_state.emit(holstered_state)
	pass # Replace with funceplace with function body.
