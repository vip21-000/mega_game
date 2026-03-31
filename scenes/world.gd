extends Node2D

func _ready():
	var player = get_node("player")
	player.SPEED = 150

func _on_minigame_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mini_game.tscn")
