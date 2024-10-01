class_name RetreatAbility extends PaddleAbility

@export var retreat_by:float = 75
@export var duration:float = 0.5

@onready var original_x:float = paddle.position.x

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
	elastic_tween(tween, paddle, "position:x", original_x - retreat_by)
	paddle.movement.can_sprint = false
	paddle.movement.speed_effectiveness = 0.5

func on_finish() -> void:
	var tween := create_tween()
	elastic_tween(tween, paddle, "position:x", original_x)
	paddle.movement.can_sprint = true
	paddle.movement.speed_effectiveness = 1
