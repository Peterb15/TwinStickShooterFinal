extends Area2D
@onready var lightning_sfx: AudioStreamPlayer2D = $lightningSFX

var velocity: Vector2 = Vector2(0,0)
var count: int = 4
var fowardB: Vector2

	
	
func fire(forward: Vector2, speed: float):
	$AnimationPlayer.play("lightning_start")
	lightning_sfx.play()
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
		if(body is Enemy):
			(body as Enemy).hit(1)
		if(body is EnemyTest):
			(body as EnemyTest).hit(1)
		for other_body in $SenseRange.get_overlapping_bodies():
			if other_body != body and (other_body is Enemy or EnemyTest) and count != 0:  # Make sure it's an Enemy
				var direction = (other_body.position - position).normalized()  # Calculate direction
				fire(Vector2.from_angle(direction.angle()), 600)
				count = count - 1
				break  # Stop after firing at the first detected enemy
	else:
		queue_free()
