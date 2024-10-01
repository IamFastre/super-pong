class_name PaddleAbility extends Component2D

@export var controller:PaddleController

@onready var game := GameMode.get_instance(parent)
@onready var is_left := game.left_paddle == (parent as PaddleNode)
@onready var paddle := parent as PaddleNode
@onready var opponent := game.right_paddle if is_left else game.left_paddle

var sprinting_activates:bool = false

var started:bool = false
var running:bool = false
var finished:bool = false

#=====================================================================#

func on_start()   -> void: pass
func on_running() -> void: pass
func on_finish()  -> void: pass

#=====================================================================#

func _process(_delta:float) -> void:
	started  = controller.ability_down     or (controller.sprint_down    and sprinting_activates)
	running  = controller.ability_pressed  or (controller.sprint_pressed and sprinting_activates)
	finished = controller.ability_up       or (controller.sprint_up      and sprinting_activates)

	if started:  on_start()
	if running:  on_running()
	if finished: on_finish()
