extends Node3D

var werewolf = Werewolf
# Finds distance of player, if player is somehow out of range, werewolf will cheat to resolve
func physics_process(delta: float) -> void:
	print("running")
	var bodies = werewolf.smell_node.get_overlapping_bodies()
	print("smell:"+werewolf.distance)
	if werewolf.player in bodies:
		werewolf.distance = werewolf.global_position.distance_to(werewolf.player.global_position)
		werewolf.in_range = true
	else:
		werewolf.in_range = false
