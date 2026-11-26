class_name Player
extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 10
@onready var base_speed = speed
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
var follow_speed = 10

var target_velocity = Vector3.ZERO

# Camera and Movement
func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = ($Pivot.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


	if direction:
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
		target_velocity.z = direction.z * speed
	else:
		target_velocity.x = lerp(target_velocity.x, direction.x * speed, delta * 7.0)
		target_velocity.z = lerp(target_velocity.z, direction.z * speed, delta * 7.0)

	if Input.is_action_pressed("shuffle"):
		speed = base_speed/2
	elif direction:
		speed = base_speed
		if(not $Footsteps.is_playing()):
			$Footsteps.play()

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	
	
	velocity = target_velocity
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.006)
		$Pivot/Camera3D.rotate_x(-event.relative.y * 0.006)
		$Pivot/Camera3D.rotation.x = clamp($Pivot/Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))

	

func audio():
	pass
