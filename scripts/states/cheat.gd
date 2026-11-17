extends WerewolfState
#Useless right now, maye change to Stalk if time allows
func enter(previous_state_path: String, data := {}) -> void:
	if werewolf.can_see:
		finished.emit(ATTACK)
		pass
	else:
		finished.emit(SEE)
