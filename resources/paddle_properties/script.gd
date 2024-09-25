class_name PaddleProperties extends Resource

@export var name:String = "Paddle"

@export_group("Movement")
@export var speed:float = 500
@export var sprint_speed:float = 750
@export var can_sprint:bool = true

@export_group("Layout")
@export var color:Color = Color.WHITE
@export var scale:Vector2 = Vector2.ONE
@export var displacement:Vector2 = Vector2.ZERO
