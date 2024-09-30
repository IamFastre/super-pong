class_name HumanController extends PaddleController

@export_enum("Disabled", "P1", "P2") var mode:int = 1

func p1():
	v_axis = Input.get_axis("p1_up", "p1_down")
	sprint_down = Input.get_action_strength("p1_sprint") > 0

func p2():
	v_axis = Input.get_axis("p2_up", "p2_down")
	sprint_down = Input.get_action_strength("p2_sprint") > 0

#=====================================================================#

func _process(_delta:float) -> void:
	match mode:
		1: p1()
		2: p2()
