extends PerceptionSystem

# Finds distance of player, if player is somehow out of range, werewolf will cheat to resolve
func _physics_process(delta: float) -> void:
	var bodies = werewolf.smell_node.get_overlapping_bodies()
	if werewolf.player in bodies:
		werewolf.distance = werewolf.global_position.distance_to(werewolf.player.global_position)
		werewolf.target = werewolf.player
	elif bodies:
		werewolf.distance = werewolf.global_position.distance_to(werewolf.bodies[0].global_position)
		werewolf.target = bodies[0]

func _process(delta: float) -> void:
	var distances: Array[float] = [10, 20, 30, 40, 50]
	for weights_reward in distances:
		if werewolf.distance <= weights_reward:
			werewolf.smell_weight = .3 + weights_reward/100
			return
	
