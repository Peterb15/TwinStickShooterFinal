extends CharacterStateMachine
class_name ShootingEnemy

@export var hp = 3;
func hit(damage_number: int):
		hp -= damage_number
		if(hp <= 0):
			queue_free()
			
