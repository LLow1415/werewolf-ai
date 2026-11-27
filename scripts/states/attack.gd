extends WerewolfState

#Changes speed to 12 so can attack easier
func enter(previous_state_path: String, data := {}) -> void:
	werewolf.speed = 10
	
#Attempts to attack, or dive
func physics_update(_delta: float) -> void:
	
	if not werewolf.cooldown:
		werewolf.navigation_agent.set_target_position(werewolf.target.global_position)
		if werewolf.in_range:
			if werewolf.target == werewolf.player and werewolf.affection == 100:
				finished.emit(PLAY)
			werewolf.target.health -= 10
			if werewolf.target.health <= 0:
				finished.emit(EAT)
			else:
				start_cooldown()
	if werewolf.health < werewolf.previous_health:
		werewolf.health = werewolf.previous_health
		finished.emit(INJURED)
	sight_check()

func start_cooldown():
	werewolf.cooldown = true
	await get_tree().create_timer(1.5).timeout
	werewolf.cooldown = false
			
func sight_check():
	if not werewolf.can_see:
		await get_tree().create_timer(6).timeout
		if not werewolf.can_see:
			finished.emit(HUNT)
