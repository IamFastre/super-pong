class_name HumanMovement extends PaddleMovement

@export var input_mode:PlayerInfo.ID = PlayerInfo.ID.P1

var get_input:Callable

func input_player1():
	direction = Input.get_axis("p1_up", "p1_down")
	is_sprinting = Input.get_action_strength("p1_sprint")

func input_player2():
	direction = Input.get_axis("p2_up", "p2_down")
	is_sprinting = Input.get_action_strength("p2_sprint")

func setup(id:PlayerInfo.ID):
	input_mode = id

#=====================================================================#

func _ready() -> void:
	super._ready()
	match input_mode:
		PlayerInfo.ID.P1:
			get_input = input_player1
		PlayerInfo.ID.P2:
			get_input = input_player2

func _process(delta:float) -> void:
	if get_input:
		get_input.call()
	move(delta)
