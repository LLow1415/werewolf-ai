extends RigidBody3D

var attack_type: String = "left"

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1

func _on_body_entered(body: Node) -> void:
	if attack_type == "left":
		body.health -= 10
	elif attack_type == "right":
		body.affection = 100
	queue_free()
