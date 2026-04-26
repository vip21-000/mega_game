extends Node2D

@onready var player : Player = $player

@onready var npcs = [$NPC1, $NPC2, $NPC3]
@onready var fade_screen = $CanvasLayer/FadeScreen
@onready var fade_label = $CanvasLayer/FadeScreen/Label


func _ready():
	add_to_group("world")
	player.SPEED = 150
	for npc in npcs:
		npc.visible = false
	fade_screen.visible = false
	if Glob.player_prev_position.x != 0:
		player.position = Glob.player_prev_position
		
	setup_npc()
	apply_effects()
	
func _on_minigame_pressed() -> void:
	var npc = get_current_npc()
	npc.visible = false
	player.SPEED = 0   # блокуємо рух
	show_transition()

func show_transition():
	fade_screen.visible = true
	
	match Glob.stage:
		1:
			fade_label.text = "Після важкої роботи, коли останнє поліно впало, залишилось відчуття втоми й задоволення.
Тут сусід покликав до себе й накрив щедру поляну — робота змінилася відпочинком і гарним настроєм."
			fade_screen.size = Vector2(1154.0, 652.0)
		2:
			fade_label.text = "Світ починає плисти..."
			fade_screen.size = Vector2(1154.0, 652.0)
		3:
			fade_label.text = "Ти вже майже нічого не контролюєш..."
			fade_screen.size = Vector2(1154.0, 652.0)
	
	await get_tree().create_timer(5.0).timeout
	
	get_tree().change_scene_to_file("res://scenes/mini_game.tscn")

func setup_npc():
	var npc = get_current_npc()
	var label = npc.get_node("Label")
	var button = npc.get_node("Button")
	match Glob.stage:
		0:
			label.text = "Сусіде, допоможи наколоти
дрова, я в боргу не залишуся"
		1:
			label.text = "Тепер складніше 😈"
		2:
			label.text = "Останній рівень 💀"
	
	button.text = "GO"
	button.pressed.connect(_on_npc_button_pressed)

func _on_npc_button_pressed():
	var npc = get_current_npc()
	npc.visible = false
	Glob.player_prev_position = player.position
	show_transition()

func get_current_npc():
	return npcs[Glob.stage]
	
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
