extends WerewolfState
#Useless right now, maye change to Stalk if time allows
func enter(previous_state_path: String, data := {}) -> void:
	werewolf.target.queue_free()
	finished.emit(SLEEP)
