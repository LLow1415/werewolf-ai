class_name Werewolf

extends CharacterBody3D
#Keep Allty

# Self Nodes
@onready var vision_node = $Vision
@onready var smell_node = $Smell
@onready var vision_ray = $Vision/RayCast3D
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

# External Nodes
@export var player: Node3D
@export var nav: NavigationRegion3D
@onready var movement_target_position: Vector3 = player.global_position

# Self Variables
@export var speed = 14
@export var fall_acceleration = 20
var target_velocity = Vector3.ZERO

# AI Variables
var in_range = false
var can_see = false
var in_scent_range = false
var scent = Global.scent

# NavMesh Code
func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 1.0
	navigation_agent.target_desired_distance = 1.5

	# Make sure to not await during _ready.
	actor_setup.call_deferred()
	
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	# Now that the navigation map is no longer empty, set the movement target.
	
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		print("done")
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	
	# Moving the Character
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()
	
func _process(delta: float) -> void:
	print(global_position.y)
