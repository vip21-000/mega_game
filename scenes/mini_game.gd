extends Node2D

@onready var score_label = $ScoreLabel
var timer := 0.0
@export var spawn_interval := 1.5
@export var loot_scene = preload("res://scenes/loot/loot.tscn")
var loot_types = ["vodka", "beer", "salo", "apple"]


func _ready():
	var player = get_node("player")
	player.SPEED = 200
	randomize()
	spawn_loot()
	add_to_group("game")
	update_ui()

func _process(delta):
	timer += delta
	
	if timer >= spawn_interval:
		spawn_loot()
		timer = 0.0




func spawn_loot():
	var loot = loot_scene.instantiate()
	loot.loot_type = loot_types[randi() % loot_types.size()]
	loot.position.x = randf_range(250, 850)
	loot.position.y = -710
	
	add_child(loot)


var score = 0             # загальний рахунок
var can_collect_score = true  # чи можна збирати лут зараз
var current_limit = 0     # поточний рахунок до ліміту 9

func update_ui():
	score_label.text = "Score: " + str(score)
