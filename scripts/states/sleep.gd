extends WerewolfState
#Useless right now, maye change to Stalk if time allows
func enter(previous_state_path: String, data := {}) -> void:
	werewolf.navigation_agent.set_target_position(werewolf.home.global_position)
	
func update(_delta: float) -> void:
	if werewolf.navigation_agent.is_navigation_finished():
		await get_tree().create_timer(15).timeout
		finished.emit(HUNT)
