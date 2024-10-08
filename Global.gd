extends Node

#@onready var startMenu_scene: Resource = load("res://StartMenu.tscn")
@onready var player_scene: Resource = load("res://actors/player/player.tscn")

# Flag to check if it's the first time running the game
var is_first_time: bool = true

# Function to call the first-time scene
func load_first_time_scene():
	if is_first_time:
		# Load the first-time scene here
		get_tree().change_scene_to_file("res://StartMenu.tscn")
		is_first_time = false # Update the flag to indicate the game has already started
