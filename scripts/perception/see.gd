extends Node3D

var werewolf = Werewolf

func enter(previous_state_path: String, data := {}) -> void:
	print("see")


#Checks if playher is in vision cone, if it completes its path, and the player isn't, then smells area.
# If player is in cone, attempts to shoot a ray cast to see if player is in direct line of sight, then attacks
# If player isn't in direct line of sight, listens for sound
func physics_process(_delta: float) -> void:
	var bodies = werewolf.vision_node.get_overlapping_bodies()
	if werewolf.player in bodies:
		# werewolf.in_range = true
		werewolf.vision_ray.target_position = werewolf.vision_ray.to_local(werewolf.player.global_position)
		if werewolf.vision_ray.is_colliding():
			if werewolf.vision_ray.get_collider() == werewolf.player:
				print("player found")
				werewolf.can_see = true
			else:
				werewolf.can_see = false
	elif werewolf.navigation_agent.is_navigation_finished() and werewolf.player not in bodies:
		# werewolf.in_range = false
		pass
