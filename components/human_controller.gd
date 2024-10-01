class_name HumanController extends PaddleController

@export_enum("Disabled", "P1", "P2") var mode:int = 1

func p1():
	v_axis = Input.get_axis("p1_up", "p1_down")

	sprint_pressed = Input.is_action_pressed("p1_sprint")
	sprint_down = Input.is_action_just_pressed("p1_sprint")
	sprint_up = Input.is_action_just_released("p1_sprint")

	ability_pressed = Input.is_action_pressed("p1_ability")
	ability_down = Input.is_action_just_pressed("p1_ability")
	ability_up = Input.is_action_just_released("p1_ability")

func p2():
	v_axis = Input.get_axis("p2_up", "p2_down")
	sprint_pressed = Input.is_action_pressed("p2_sprint")
	sprint_down = Input.is_action_just_pressed("p2_sprint")
	sprint_up = Input.is_action_just_released("p2_sprint")

	ability_pressed = Input.is_action_pressed("p2_ability")
	ability_down = Input.is_action_just_pressed("p2_ability")
	ability_up = Input.is_action_just_released("p2_ability")

#=====================================================================#

func _process(_delta:float) -> void:
	match mode:
		1: p1()
		2: p2()
