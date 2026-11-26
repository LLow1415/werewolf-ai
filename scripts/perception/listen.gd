extends Node3D

var werewolf = Werewolf

#Checks if player is nearby, if they are, give a number to determine where they are, and act based on that
func physics_process(previous_state_path: String, data := {}) -> void:
	var footsteps = werewolf.player.get_child(0)
	if footsteps.is_playing() && werewolf.distance < 15:
		werewolf.can_hear = true
	else:
		werewolf.can_hear = false
