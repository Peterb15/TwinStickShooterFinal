extends Node2D


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
	pass # Replace with function bodyplace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # RepReplace with function body.
