class_name HumanInfo extends PlayerInfo

@export_enum("Disabled", "P1", "P2") var mode:int = 0

func get_controller() -> PaddleController:
	var human:HumanController = HUMAN_CONTROLLER.new()
	human.name = "Human[%s]Controller" % mode
	human.mode = mode
	return human
