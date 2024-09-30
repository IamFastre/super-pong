class_name PaddleMovement extends ComponentNode2D

@export var controller:PaddleController

@export var move_speed:float = 500
@export var sprint_speed:float = 750
@export var can_sprint:bool = true
@export_range(0, 1) var ball_maneuver:float = 0.5

var velocity = 0.0
var direction:float = 0.0
var disabled:bool = false

var is_moving:bool = false :
	get: return abs(velocity) > 0.0

var is_sprinting:bool = false :
	set(value): is_sprinting = value and can_sprint

#=====================================================================#

func move(delta:float) -> void:
	if disabled:
		return

	var multiplier = sprint_speed if is_sprinting else move_speed
	velocity = direction * multiplier
	parent.position.y += velocity * delta

#=====================================================================#

func _ready() -> void:
	if "movement" in parent:
		parent.movement = self

func _process(delta:float) -> void:
	direction = controller.v_axis
	is_sprinting = controller.sprint_down
	move(delta)
