extends Node2D

@onready var player : Player = $player

func _ready():
	player.SPEED = 150
	if Glob.player_prev_position.x != 0:
		print("Teleported")
		player.position = Glob.player_prev_position
	
func _on_minigame_pressed() -> void:
	Glob.player_prev_position = $player.position
	get_tree().change_scene_to_file("res://scenes/mini_game.tscn")
	
