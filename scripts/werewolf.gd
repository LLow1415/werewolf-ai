class_name Werewolf

extends CharacterBody3D
#Keep Allty

# Self Nodes
@onready var vision_node = $Pivot/Perception/Vision
@onready var smell_node = $Pivot/Perception/Smell
@onready var vision_ray = $Pivot/Perception/Vision/RayCast3D
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

# External Nodes
@export var player: Node3D
@export var nav: NavigationRegion3D
@onready var movement_target_position: Vector3 = global_position

# Self Variables
@onready var speed = 7
@export var fall_acceleration = 20
var target_velocity = Vector3.ZERO
var theta: float

# AI Variables
var can_smell = false
var in_range = false
var can_see = false
var can_hear = false
var scent = Global.scent
@onready var distance: float

# NavMesh Code
func _ready():
	navigation_agent.path_desired_distance = 1.0
	navigation_agent.target_desired_distance = 1.5
	actor_setup.call_deferred()
	
# Wait for the first physics frame so navmesh can sync
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta: float) -> void:
	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var direction = current_agent_position.direction_to(next_path_position)
	
	if(direction):
		theta = wrapf(atan2(direction.x,direction.z) - $Pivot.rotation.y, -PI, PI)
		$Pivot.rotation.y += clampf(10 * delta, 0, abs(theta)) * sign(theta) 

	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()
	

func _process(delta: float) -> void:
	if(can_smell):
		distance = global_position.distance_to(player.global_position)

func _on_smell_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	can_smell = true


func _on_smell_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	can_smell = false


func _on_vision_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	in_range = true


func _on_vision_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	in_range = false


func _on_listen_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	can_hear = true


func _on_listen_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	can_hear = false
