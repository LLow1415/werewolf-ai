class_name PerceptionSystem extends Node3D

var werewolf: Werewolf

func _ready() -> void:
	await owner.ready
	werewolf = owner as Werewolf
	assert(werewolf != null, "In wrong node, must be in werewolf")
