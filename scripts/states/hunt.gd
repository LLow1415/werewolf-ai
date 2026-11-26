extends WerewolfState
var smell_pos: Vector3
var searched: Vector3
var weight = 3
# Tries going to player based on smell and distance, or listening
func enter(previous_state_path: String, data := {}) -> void:
	pass

# If player nearby, wander around till they find
func physics_update(_delta: float) -> void:
	if werewolf.distance < 10:
		searched = Vector3(randi_range(0,3)+smell_pos.x,smell_pos.y,randi_range(0,3)+smell_pos.z)
	else:
		smell_pos = Vector3(werewolf.player.global_position.x-((werewolf.distance/weight)*sign(werewolf.player.global_position.x)), werewolf.player.global_position.y,werewolf.player.global_position.z-((werewolf.distance/weight)*sign(werewolf.player.global_position.z)))
		werewolf.navigation_agent.set_target_position(smell_pos)
