extends Node2D
@onready var menu_music: AudioStreamPlayer2D = $MenuMusic


func _ready():
	menu_music.play()
	# Call the singleton's function to load the scene if it's the first time
	#Global.load_first_time_scene()
