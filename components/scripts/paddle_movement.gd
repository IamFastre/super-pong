class_name PaddleMovement extends ComponentNode2D

@export var speed_multiplier:float = 500
@export var sprint_speed_multiplier:float = 1000

var velocity = 0.0
var direction:float = 0.0
var is_sprinting:bool = false
var disabled:bool = false

#=====================================================================#

func move(delta:float) -> void:
	if disabled:
		return

	var multiplier = sprint_speed_multiplier if is_sprinting else speed_multiplier
	velocity = direction * multiplier
	parent.position.y += velocity * delta

#=====================================================================#

func _ready() -> void:
	if "movement" in parent:
		parent.movement = self
