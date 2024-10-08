extends CharacterStateMachine
class_name EnemyTest

@export var hp = 3;
@export var chase_speed : float = 50.0
var target : CharacterBody2D

func hit(damage_number: int):
		hp -= damage_number
		if(hp <= 0):
			queue_free()
			


func _on_melee_body_entered(body: Node2D) -> void:
	if(body is not TileMapLayer):
		if(body is Player):
			(body as Player).hit(1)
			queue_free()
