class_name Werewolf

extends CharacterBody3D

# Called when the node enters the scene tree for the first time.
enum states {
	IDLE, 
	HUNT, 
	ATTACK,
	SLEEP,
	INJURED,
	PLAY,
	EAT,
	SMELL,
	SEE,
	CHEAT
	}
	
var game_state: states = states.IDLE
var in_range = false
var can_see = false
var can_smell = false

@onready var vision_node = $Vision
@onready var smell_node = %Smell

@export var player: Node3D
@onready var vision_ray = $Vision/RayCast3D

var scent = Global.scent

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_case()
	pass
	
func _physics_process(delta: float) -> void:
	if in_range and not can_see:
		vision_ray.target_position = vision_ray.to_local(player.global_position)
		if vision_ray.is_colliding():
			if vision_ray.get_collider() == player:
				can_see = true
			else:
				print("missed")
				can_see = false
				
	

	

# Switches game state
func state_case():
	match game_state:
		states.IDLE:
			idle()
		states.HUNT:
			hunt()
		states.ATTACK:
			attack()
		states.SLEEP:
			sleep()
		states.INJURED:
			injured()
		states.PLAY:
			play()
		states.EAT:
			eat()
		states.SMELL:
			smell()
		states.SEE:
			see()
		states.CHEAT:
			cheat()

#State Functions:

#Sit still and wait to see player, mainly used at startup
func idle():
	if can_see: 
		game_state = states.HUNT
		state_case()
	
	
#Search aroound for player, mainly uses smell and sight, then transitions to either attack
func hunt():
	if not in_range:
		# Wander aimlessly, and cheat if cannot find after a minute
		smell()
	
	
func attack():
	pass
func sleep():
	pass
	
func play():
	pass
	
func injured():
	pass

func eat():
	pass

#Smell area, will be more weighted towards player if player is closer
func smell():
	var bodies = smell_node.get_overlapping_bodies()
	if player not in bodies:
		in_range = false
		hunt()
	else:
		var distance = self.global_position.distance_to(Player.global_position)
	
func see():
	var bodies = vision_node.get_overlapping_bodies()
	in_range = true
	if player in bodies:
		vision_ray.target_position = vision_ray.to_local(player.global_position)
		if vision_ray.is_colliding():
			if vision_ray.get_collider() == player:
				attack()
			else:
				hunt()
		
func cheat():
	pass
