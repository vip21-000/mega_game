extends Node2D

@onready var player : Player = $player

@onready var npc = $NPC
@onready var npc_label = $NPC/Label
@onready var npc_button = $NPC/Button
@onready var fade_screen = $CanvasLayer/FadeScreen
@onready var fade_label = $CanvasLayer/FadeScreen/Label


func _ready():
	add_to_group("world")
	player.SPEED = 150
	npc.visible = false
	fade_screen.visible = false
	if Glob.player_prev_position.x != 0:
		print("Teleported")
		player.position = Glob.player_prev_position
		
	setup_npc()
	apply_effects()
	
func _on_minigame_pressed() -> void:
	npc.visible = false
	player.SPEED = 0   # блокуємо рух
	show_transition()

func show_transition():
	fade_screen.visible = true
	
	match Glob.stage:
		1:
			fade_label.text = "Після важкої роботи, коли останнє поліно впало, залишилось відчуття втоми й задоволення.
Тут сусід покликав до себе й накрив щедру поляну — робота змінилася відпочинком і гарним настроєм."
		2:
			fade_label.text = "Світ починає плисти..."
		3:
			fade_label.text = "Ти вже майже нічого не контролюєш..."
	
	await get_tree().create_timer(5.0).timeout
	
	get_tree().change_scene_to_file("res://scenes/mini_game.tscn")

func setup_npc():
	match Glob.stage:
		0:
			npc_label.text = "Сусіде, допоможи наколоти
дрова, я в боргу не залишуся"
		1:
			npc_label.text = "Тепер складніше 😈"
		2:
			npc_label.text = "Останній рівень 💀"
	
	npc_button.text = "GO"
	npc_button.pressed.connect(_on_npc_button_pressed)

func _on_npc_button_pressed():
	npc.visible = false
	Glob.player_prev_position = player.position
	show_transition()


func start_invert_controls():
	player.invert = true


func apply_effects():
	match Glob.stage:
		1:
			player.drunk_idle = true
		
		2:
			player.drunk_walk = true 
		
		3:
			start_invert_controls()
