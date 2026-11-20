extends WerewolfState

#Checks if player is nearby, if they are, give a number to determine where they are
func enter(previous_state_path: String, data := {}) -> void:
	var bodies = werewolf.smell_node.get_overlapping_bodies()
	if werewolf.player not in bodies:
		werewolf.in_range = false
	else:
		var distance = self.global_position.distance_to(werewolf.player.global_position)
