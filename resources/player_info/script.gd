class_name PlayerInfo extends Resource

const HUMAN_CONTROLLER:GDScript = preload("res://components/scripts/human_controller.gd")
const CPU_CONTROLLER:GDScript = preload("res://components/scripts/cpu_controller.gd")

enum ID {
	NONE,
	P1,
	P2,
}

enum DIFFICULTY {
	NONE,
	EASY,
	MEDIUM,
	HARD,
}

@export var name:String
@export var icon:Texture2D
@export var is_human:bool
@export var id:ID = ID.NONE
@export var difficulty:DIFFICULTY = DIFFICULTY.NONE

func get_controller() -> PaddleController:
	if is_human:
		var human:HumanController = HUMAN_CONTROLLER.new()
		human.name = "HumanController"
		human.mode = id
		return human
	else:
		var cpu:CPUController = CPU_CONTROLLER.new()
		cpu.name = "CPUController"
		cpu.mode = difficulty
		return cpu
