extends WerewolfState
var target_pos
#Useless right now, maye change to Stalk if time allows
func enter(previous_state_path: String, data := {}) -> void:
	print("play")
	pass

func physics_update(_delta: float) -> void:
		target_pos = Vector3(werewolf.target.global_position.x-(2-werewolf.global_position.x*sign(werewolf.target.global_position.x)), werewolf.target.global_position.y,werewolf.target.global_position.z-(2-werewolf.global_position.z*sign(werewolf.target.global_position.z)))
		if werewolf.navigation_agent.is_navigation_finished():
			werewolf.navigation_agent.set_target_position(target_pos)
