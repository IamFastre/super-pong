class_name PaddleNode extends StaticBody2D

@export var properties:PaddleProperties
@export var movement:PaddleMovement

func _ready() -> void:
    # Layout
    modulate = properties.color
    scale *= properties.scale
    position += properties.displacement if position.x < Constants.center.x else properties.displacement * Vector2(-1, 1)
