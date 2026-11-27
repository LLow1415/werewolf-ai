extends PerceptionSystem

# Checks if player is nearby, if they are, give a number to determine where they are, and act based on that
func _process(delta: float) -> void:
	var footsteps = werewolf.player.get_child(0)
	var distances: Array[float] = [30, 40, 50, 60, 70]
	for weights_reward in distances:
		if werewolf.distance <= weights_reward and footsteps.is_playing():
			werewolf.audio_weight = .1 + weights_reward/100
		elif not footsteps.is_playing():
			werewolf.audio_weight = .5
