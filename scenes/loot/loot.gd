extends Area2D

@export var loot_type: String = "vodka"
@export var fall_speed: float = 200.0


func _ready():
	match loot_type:
		"vodka":
			$Sprite.texture = preload("res://scenes/loot/vodka.png")
			$Sprite.scale = Vector2(0.125, 0.125)
			var shape = CapsuleShape2D.new()
			shape.radius = 11.125
			shape.height = 41.25
			$Collision.shape = shape
		"beer":
			$Sprite.texture = preload("res://scenes/loot/beer.png")
			$Sprite.scale = Vector2(0.125, 0.125)
			var shape = CapsuleShape2D.new()
			shape.radius = 14.625
			shape.height = 37.5
			$Collision.shape = shape
		"salo":
			$Sprite.texture = preload("res://scenes/loot/salo.png")
			$Sprite.scale = Vector2(0.125, 0.125)
			var shape = RectangleShape2D.new()
			shape.size = Vector2(56, 10.75)
			$Collision.shape = shape
		"apple":
			$Sprite.texture = preload("res://scenes/loot/apple.png")
			$Sprite.scale = Vector2(0.125, 0.125)
			var shape = CircleShape2D.new()
			shape.radius = 15.625
			$Collision.shape = shape

func _process(delta):
	position.y += fall_speed * delta
	if position.y > 800:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		var game = get_tree().get_first_node_in_group("game")
		if game:
			match loot_type:
				"vodka":
					if game.can_collect_score and game.current_limit < 9:
						game.current_limit += 3
						if game.current_limit > 9:
							game.current_limit = 9
						game.score += 3
						print("+3")
						if game.current_limit >= 9:
							game.can_collect_score = false
							print("LIMIT REACHED")
				"beer":
					if game.can_collect_score and game.current_limit < 9:
						game.current_limit += 1
						if game.current_limit > 9:
							game.current_limit = 9
						game.score += 1
						print("+1")
						if game.current_limit >= 9:
							game.can_collect_score = false
							print("LIMIT REACHED")
				"salo":
					game.can_collect_score = true
					game.current_limit = 0
					print("RESET LIMIT")
				"apple":
					game.score -= 5
					print("-5 💀")

			# обмеження максимум 50
			if game.score > 50: 
				game.score = 50 
				print("YOU WIN 🏆")
			
			if game.score < 0: 
				game.score = 0
			
			game.update_ui()
			queue_free()
