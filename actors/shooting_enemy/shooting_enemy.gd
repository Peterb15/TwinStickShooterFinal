extends CharacterStateMachine
class_name ShootingEnemy
@onready var enemy_sfx: AudioStreamPlayer2D = $enemySFX

@export var hp = 3;

func hit(damage_number: int):
		enemy_sfx.play()
		await enemy_sfx
		hp -= damage_number
		if(hp <= 0):
			queue_free()
			
