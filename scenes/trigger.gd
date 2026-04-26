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
	var world = get_tree().get_first_node_in_group("world")
	
	if world == null:
		return
	if Glob.stage >= world.npcs.size():
		return
	
	var npc = world.npcs[Glob.stage]
	
	npc.visible = true
	world.player.SPEED = 0
	
	Glob.stage += 1
