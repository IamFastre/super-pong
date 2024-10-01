class_name PlayerInfo extends Resource

const HUMAN_CONTROLLER:GDScript = preload("res://components/human_controller.gd")
const CPU_CONTROLLER:GDScript = preload("res://components/cpu_controller.gd")

@export var name:String
@export var icon:Texture2D

var is_human:bool :
	get: return self is HumanInfo

func get_controller() -> PaddleController:
	assert(false, "Method 'get_controller' should be overridden")
	return null
