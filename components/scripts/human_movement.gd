class_name HumanMovement extends PaddleMovement

@export var input_mode:PlayerInfo.ID = PlayerInfo.ID.P1

var get_input:Callable

func player1_input():
	direction = Input.get_axis("p1_up", "p1_down")
	is_sprinting = Input.get_action_strength("p1_sprint")

func player2_input():
	direction = Input.get_axis("p2_up", "p2_down")
	is_sprinting = Input.get_action_strength("p2_sprint")

func setup(id:PlayerInfo.ID):
	input_mode = id

#=====================================================================#

func _ready() -> void:
	match input_mode:
		PlayerInfo.ID.P1:
			get_input = player1_input
		PlayerInfo.ID.P2:
			get_input = player2_input

func _physics_process(delta:float) -> void:
	if get_input:
		get_input.call()
	move(delta)
