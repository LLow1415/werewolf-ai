extends WerewolfState
#Useless right now, maye change to Stalk if time allows
func enter(previous_state_path: String, data := {}) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	await get_tree().physics_frame
	werewolf.navigation_agent.set_target_position(werewolf.player.global_position)
	
