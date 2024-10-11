extends Node2D

@onready var level_2_music: AudioStreamPlayer2D = $Level2Music

func _ready() -> void:
	level_2_music.play()
func _physics_process(delta: float) -> void:
	var enemyCount = get_node("Enemies").get_child_count()
	print(enemyCount)
	if(enemyCount == 0):
		get_tree().change_scene_to_file("res://Victory/victory.tscn")
