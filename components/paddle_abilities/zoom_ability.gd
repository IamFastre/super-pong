class_name ZoomAbility extends PaddleAbility

@export var icon:TextureRect
@export var timer:Timer
@export var inactive_color:Color = Color("777777")
@export var general_duration:float = 0.25
@export var rotation_duration:float = 1.0

@onready var original_color:Color = icon.modulate

var recharging:bool = false
var closest_ball:BallNode :
	get:
		return game.closest_ball_to((not is_left) as int)

#=====================================================================#

func elastic_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant, custom_dur:float = 0):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, custom_dur if custom_dur else general_duration) \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_ELASTIC)

func ease_in_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant, custom_dur:float = 0):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, custom_dur if custom_dur else general_duration) \
		.set_ease(Tween.EASE_IN)

#=====================================================================#

func on_start() -> void:
	if recharging or not closest_ball: return

	var tween1 := create_tween()
	elastic_tween(tween1, paddle, "position:y", closest_ball.position.y)
	ease_in_tween(tween1, icon, "modulate:r", inactive_color.r)
	ease_in_tween(tween1, icon, "modulate:g", inactive_color.g)
	ease_in_tween(tween1, icon, "modulate:b", inactive_color.b)

	recharging = true
	timer.start()
	await timer.timeout
	recharging = false

	var tween2 := create_tween()
	elastic_tween(tween2, icon, "rotation", icon.rotation + 2 * PI, rotation_duration)
	ease_in_tween(tween2, icon, "modulate:r", original_color.r)
	ease_in_tween(tween2, icon, "modulate:g", original_color.g)
	ease_in_tween(tween2, icon, "modulate:b", original_color.b)

#=====================================================================#

func _process(delta:float) -> void:
	super._process(delta)
	timer.paused = not game.running
