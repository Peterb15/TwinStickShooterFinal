extends Node2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
	pass # Replace with function body.



func _on_play_again_2_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
