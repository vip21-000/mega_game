extends Area2D

@export var trigger_id := 0

var used := false


func _on_body_entered(body):
	
	print("ENTERED TRIGGER")
	print("stage:", Glob.stage, " trigger:", trigger_id)
	if used:
		return

	if body.is_in_group("player"):
		if Glob.stage == trigger_id:
			activate()

func activate():
	print("ACTIVATE!!!")
	
	var world = get_tree().get_first_node_in_group("world")
	
	world.npc.visible = true
	world.npc.position = Vector2(1288.0, -107.0)  # тимчасово
	
	Glob.stage += 1
