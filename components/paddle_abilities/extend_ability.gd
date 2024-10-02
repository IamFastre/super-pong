class_name ExtendAbility extends PaddleAbility

@export var sprite:ColorRect
@export var collision:CollisionShape2D
@export var duration:float = 0.75
@export var extend_by:float = 80
@export_range(0 , 1) var extended_speed_effectiveness:float = 0.6

@onready var shape := collision.shape as RectangleShape2D
@onready var original_length:float = sprite.size.y
@onready var original_y:float = sprite.position.y

#=====================================================================#

func elastic_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, duration) \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_ELASTIC)

#=====================================================================#

func on_start() -> void:
	var tween := create_tween()
	elastic_tween(tween, shape, "size:y", original_length + extend_by)
	elastic_tween(tween, sprite, "size:y", original_length + extend_by)
	elastic_tween(tween, sprite, "position:y", original_y - extend_by / 2)
	paddle.movement.speed_effectiveness = extended_speed_effectiveness

func on_finish() -> void:
	var tween := create_tween()
	elastic_tween(tween, shape, "size:y", original_length)
	elastic_tween(tween, sprite, "size:y", original_length)
	elastic_tween(tween, sprite, "position:y", original_y)
	paddle.movement.speed_effectiveness = 1
