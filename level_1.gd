extends Node2D
@onready var menu_music: AudioStreamPlayer2D = $Level1Music


func _ready() -> void:
	menu_music.play()
	
func _physics_process(delta: float) -> void:
	var enemyCount = get_node("Enemies").get_child_count()
	print(enemyCount)
	if(enemyCount == 0):
		get_tree().change_scene_to_file("res://level_2.tscn")
		
