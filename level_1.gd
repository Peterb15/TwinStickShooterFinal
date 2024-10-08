extends Node2D



func _physics_process(delta: float) -> void:
	var enemyCount = get_node("Enemies").get_child_count()
	print(enemyCount)
	if(enemyCount == 0):
		get_tree().change_scene_to_file("res://level_2.tscn")
		
