extends Area2D

var velocity: Vector2 = Vector2(0,0)

func fire(projectile_forward: Vector2, target_position: Vector2, speed: float):
	# You can now use target_position in this function
	# Example:
	print("Firing towards target at position: ", target_position)
	
	velocity = projectile_forward * speed
	# Your projectile firing logic here

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta
	print(position)


func _on_time_to_live_timeout():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body is not TileMapLayer):
		if(body is Player):
			(body as Player).hit(1)
			queue_free()

	
