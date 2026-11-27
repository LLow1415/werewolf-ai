class_name Werewolf

extends CharacterBody3D

@onready var vision_node = $Pivot/Perception/Vision
@onready var smell_node = $Pivot/Perception/Smell
@onready var attack_node = $Pivot/Perception/AttackRange
@onready var vision_ray = $Pivot/Perception/Vision/RayCast3D
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var distance: float
@onready var movement_target_position: Vector3 = global_position
@onready var speed = 7
@onready var health = 100
@onready var previous_health = health
@onready var affection = 0
@onready var cooldown = false
@onready var weight: float
@onready var audio_weight: float = .5
@onready var smell_weight: float = .5


@export var player: Node3D
@export var fall_acceleration = 20
@export var home: Node3D 

var target_velocity = Vector3.ZERO
var theta: float
var in_range = false
var can_see = false
var can_hear = false
var target: Node3D

func _ready():
	navigation_agent.path_desired_distance = 1.0
	navigation_agent.target_desired_distance = 1.5
	actor_setup.call_deferred()

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta: float) -> void:
	if not cooldown:
		var current_agent_position: Vector3 = global_position
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		var direction = current_agent_position.direction_to(next_path_position)
		
		if(direction):
			theta = wrapf(atan2(direction.x,direction.z) - $Pivot.rotation.y, -PI, PI)
			$Pivot.rotation.y += clampf(10 * delta, 0, abs(theta)) * sign(theta) 
		
		velocity = current_agent_position.direction_to(next_path_position) * speed
	else:
		velocity = Vector3.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	weight = audio_weight + smell_weight
