extends Area2D

var velocity: Vector2 = Vector2(0,0)
@onready var bubble_sfx: AudioStreamPlayer2D = $bubbleSFX

func fire(forward: Vector2, speed: float):
	$AnimationPlayer.play("bubble_fire")
	bubble_sfx.play()
	await get_tree().create_timer(0.25).timeout
	velocity = forward * speed
	look_at(position + forward)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta


func _on_time_to_live_timeout():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body is not TileMapLayer):
		velocity = Vector2(0,0)
		$AnimationPlayer.play("bubble_hit")
		if is_instance_valid(body):
			if(body is EnemyTest):
				(body as EnemyTest).hit(1)
				await $AnimationPlayer.animation_finished
				queue_free()
			elif(body is ShootingEnemy):
				(body as ShootingEnemy).hit(1)
				await $AnimationPlayer.animation_finished
				queue_free()
