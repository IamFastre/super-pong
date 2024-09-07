@tool extends StaticBody2D

@export var collision_shape:CollisionShape2D
@export var normal:Vector2 = Vector2(0, 1)

func _ready() -> void:
	var shape := (collision_shape.shape as WorldBoundaryShape2D)
	shape.normal = normal

func _process(_delta:float) -> void:
	var shape := (collision_shape.shape as WorldBoundaryShape2D)
	shape.normal = normal
