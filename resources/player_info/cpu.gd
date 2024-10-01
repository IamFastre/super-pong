class_name CPUInfo extends PlayerInfo

@export_enum("Disabled", "Easy", "Medium", "Hard") var mode:int = 0

func get_controller() -> PaddleController:
	var cpu:CPUController = CPU_CONTROLLER.new()
	cpu.name = "CPU[%s]Controller" % mode
	cpu.mode = mode
	return cpu
