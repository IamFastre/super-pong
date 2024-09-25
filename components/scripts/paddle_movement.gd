class_name PaddleMovement extends ComponentNode2D

var properties:PaddleProperties :
	get: return (parent as PaddleNode).properties

var velocity = 0.0
var direction:float = 0.0
var disabled:bool = false

var is_moving:bool = false :
	get: return velocity > 0.0

var is_sprinting:bool = false :
	set(value): is_sprinting = value and properties.can_sprint

#=====================================================================#

func move(delta:float) -> void:
	if disabled:
		return

	var multiplier = properties.sprint_speed if is_sprinting else properties.speed
	velocity = direction * multiplier
	parent.position.y += velocity * delta

#=====================================================================#

func _ready() -> void:
	if "movement" in parent:
		parent.movement = self
