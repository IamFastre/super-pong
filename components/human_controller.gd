class_name HumanController extends PaddleController

@export var double_tap_sprint_interval:float = 0.25
@export_enum("Disabled", "P1", "P2") var mode:int = 1

var double_pressed:bool = false
var last_pressed:float = 0.0


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

	if v_axis_down:
		if Time.get_ticks_msec() / 1000.0 - last_pressed <= double_tap_sprint_interval:
			double_pressed = true
		last_pressed = Time.get_ticks_msec() / 1000.0
	elif v_axis_up:
		double_pressed = false

	sprint_pressed = sprint_pressed or double_pressed
