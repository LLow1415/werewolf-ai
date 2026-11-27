# This only exists to make autocomplete work better
class_name WerewolfState extends State

const IDLE = "Idle"
const HUNT = "Hunt"
const ATTACK = "Attack"
const SLEEP = "Sleep"
const INJURED = "Injured"
const PLAY = "Play"
const EAT = "Eat"
const SMELL = "Smell"
const SEE = "See"
const LISTEN = "Listen"

var werewolf: Werewolf


func _ready() -> void:
	await owner.ready
	werewolf = owner as Werewolf
	assert(werewolf != null, "The Werewolf state type must be used only in the werewolf scene. It needs the owner to be a Werewolf node.")
