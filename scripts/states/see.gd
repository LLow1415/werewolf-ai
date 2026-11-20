extends WerewolfState

func enter(previous_state_path: String, data := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	var bodies = werewolf.vision_node.get_overlapping_bodies()
	if werewolf.player in bodies:
		werewolf.vision_ray.target_position = werewolf.vision_ray.to_local(werewolf.player.global_position)
		if werewolf.vision_ray.is_colliding():
			if werewolf.vision_ray.get_collider() == werewolf.player:
				print("player found")
				finished.emit(ATTACK)
			else:
				finished.emit(SMELL)
	else:
		finished.emit(HUNT)
