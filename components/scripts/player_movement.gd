class_name PlayerMovement extends PaddleMovement

@export var id:PlayerInfo.ID = PlayerInfo.ID.P1

func _physics_process(delta:float) -> void:
	if id == PlayerInfo.ID.P1:
		direction = Input.get_axis("p1_up", "p1_down")
		is_sprinting = Input.get_action_strength("p1_sprint")
	elif id == PlayerInfo.ID.P2:
		direction = Input.get_axis("p2_up", "p2_down")
		is_sprinting = Input.get_action_strength("p2_sprint")

	move(delta)
