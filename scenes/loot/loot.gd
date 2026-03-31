extends Area2D

@export var loot_type: String = "vodka"
@export var fall_speed: float = 200.0

func _ready():
	match loot_type:
		"vodka":
			$Sprite.texture = preload("res://scenes/loot/vodka.png")
			$Sprite.scale = Vector2(0.1, 0.1)
			
			var shape = CapsuleShape2D.new()
			shape.radius = 8.90 
			shape.height = 33.0
			$Collision.shape = shape
			
		"beer":
			$Sprite.texture = preload("res://scenes/loot/beer.png")
			$Sprite.scale = Vector2(1, 1)
			
			var shape = CapsuleShape2D.new()
			shape.radius = 117.0
			shape.height = 300.0
			$Collision.shape = shape
			
		"salo":
			$Sprite.texture = preload("res://scenes/loot/salo.png")
			$Sprite.scale = Vector2(1, 1)
			
			var shape = RectangleShape2D.new()
			shape.size = Vector2(448.0, 86.0)
			$Collision.shape = shape
			
		"apple":
			$Sprite.texture = preload("res://scenes/loot/apple.png")
			$Sprite.scale = Vector2(1, 1)
			
			var shape = CircleShape2D.new()
			shape.radius = 125
			$Collision.shape = shape

func _process(delta):
	position.y += fall_speed * delta
	
	if position.y > 800:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		
		match loot_type:
			"vodka":
				print("+3 score")
			
			"beer":
				print("+1 score")
			
			"salo":
				print("+HP ❤️")
		
			"apple":
				print("Game Over 💀")
			
		# видаляємо предмет після підбору
		queue_free()
