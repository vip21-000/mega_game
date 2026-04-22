extends Node2D

@onready var player : Player = $player

@onready var npc = $Node2D/NPC
@onready var npc_label = $NPC/Label
@onready var npc_button = $NPC/Button

func _ready():
	add_to_group("world")
	player.SPEED = 150
	npc.visible = false
	if Glob.player_prev_position.x != 0:
		print("Teleported")
		player.position = Glob.player_prev_position
		
	setup_npc()
	apply_effects()
	
func _on_minigame_pressed() -> void:
	Glob.player_prev_position = $player.position
	get_tree().change_scene_to_file("res://scenes/mini_game.tscn")



func setup_npc():
	match Glob.stage:
		0:
			npc_label.text = "Привіт, почнемо 😏"
		1:
			npc_label.text = "Тепер складніше 😈"
		2:
			npc_label.text = "Останній рівень 💀"
	
	npc_button.text = "GO"
	npc_button.pressed.connect(_on_npc_button_pressed)

func _on_npc_button_pressed():
	npc.visible = false
	Glob.player_prev_position = player.position
	get_tree().change_scene_to_file("res://scenes/mini_game.tscn")


func start_invert_controls():
	player.invert = true


func apply_effects():
	match Glob.stage:
		1:
			player.sprite.play("happy")
		
		2:
			start_invert_controls()
		
		3:
			start_invert_controls()
			player.sprite.play("crazy")
