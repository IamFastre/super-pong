class_name ExtendAbility extends PaddleAbility

@export var sprite:ColorRect
@export var collision:CollisionShape2D
@export var extend_by:float = 80
@export var duration:float = 0.75

@onready var shape := collision.shape as RectangleShape2D
@onready var original_length:float = sprite.size.y
@onready var original_y:float = sprite.position.y

#=====================================================================#

func run_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, duration) \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_ELASTIC)

#=====================================================================#

func on_start() -> void:
	var tween := create_tween()
	run_tween(tween, shape, "size", Vector2(sprite.size.x, original_length + extend_by))
	run_tween(tween, sprite, "size", Vector2(sprite.size.x, original_length + extend_by))
	run_tween(tween, sprite, "position", Vector2(sprite.position.x, original_y - extend_by / 2))

func on_finish() -> void:
	var tween := create_tween()
	run_tween(tween, shape, "size", Vector2(sprite.size.x, original_length))
	run_tween(tween, sprite, "size", Vector2(sprite.size.x, original_length))
	run_tween(tween, sprite, "position", Vector2(sprite.position.x, original_y))
