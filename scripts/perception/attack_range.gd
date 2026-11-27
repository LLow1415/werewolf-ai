extends PerceptionSystem

func _physics_process(delta: float) -> void:
	var bodies = werewolf.attack_node.get_overlapping_bodies()
	if bodies and not werewolf.cooldown:
		werewolf.in_range = true
		werewolf.target = bodies[0]
	else:
		werewolf.in_range = false
