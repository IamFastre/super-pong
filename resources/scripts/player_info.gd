class_name PlayerInfo extends Resource

const HUMAN_MOVEMENT:PackedScene = preload("res://components/human_movement.tscn")
const CPU_MOVEMENT:PackedScene = preload("res://components/cpu_movement.tscn")

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
@export var score:int = 0
@export var is_human:bool
@export var id:ID = ID.NONE
@export var difficulty:DIFFICULTY = DIFFICULTY.NONE

func get_movement_node() -> PaddleMovement:
	return (HUMAN_MOVEMENT if is_human else CPU_MOVEMENT).instantiate()
