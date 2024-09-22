class_name PaddleMovement extends ComponentNode2D

@export var speed_multiplier:float = 500
@export var sprint_speed_multiplier:float = 750
@export var can_sprint:bool = true

var velocity = 0.0
var direction:float = 0.0
var disabled:bool = false
var is_sprinting:bool = false :
	set(value): is_sprinting = value and can_sprint

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
		if parent.movement is PaddleMovement:
			var old := parent.movement as PaddleMovement
			speed_multiplier = old.speed_multiplier
			sprint_speed_multiplier = old.sprint_speed_multiplier
			can_sprint = old.can_sprint
			old.queue_free()
		parent.movement = self
