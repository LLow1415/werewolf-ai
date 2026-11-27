extends WerewolfState
var smell_pos: Vector3
var searched: Vector3
# var werewolf.weight = 0.8
# Tries going to player based on smell and distance, or listening
func enter(previous_state_path: String, data := {}) -> void:
	pass

# If target nearby, wander around till they find
func physics_update(_delta: float) -> void:
	if werewolf.target:
		if not werewolf.target == werewolf.player:
			smell_pos = werewolf.target.global_position
		else:
			smell_pos = Vector3(werewolf.target.global_position.x-((randf_range(0,werewolf.distance)*werewolf.weight)*sign(werewolf.target.global_position.x)), werewolf.target.global_position.y,werewolf.target.global_position.z-((randf_range(0,werewolf.distance)*werewolf.weight)*sign(werewolf.target.global_position.z)))
	if not werewolf.can_see and werewolf.navigation_agent.is_navigation_finished():
		werewolf.navigation_agent.set_target_position(smell_pos)
	elif werewolf.can_see:
		finished.emit(ATTACK)
	if werewolf.health < werewolf.previous_health:
		werewolf.health = werewolf.previous_health
		finished.emit(INJURED)
