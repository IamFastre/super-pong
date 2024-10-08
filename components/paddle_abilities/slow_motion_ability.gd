class_name SlowMotionAbility extends PaddleAbility

@export_group("Ball", "effect_")
@export var effect_speed_effectiveness:float = 0.5

@export_group("Icons")
@export var icons:Control
@export var icon_fg:TextureRect
@export var icon_bg:TextureRect
@export var active_color:Color = Color("202020")

@export_group("Timing")
@export var animation_duration:float = 1.5
@export var effect_timer:Timer
@export var recharge_timer:Timer

@export_group("While Slowed Stats", "slowed_")
@export var slowed_ball_maneuver:float = 1.25
@export var slowed_speed_effectiveness:float = 1.25

@onready var original_fg_color:Color = icon_fg.modulate
@onready var original_ball_maneuver:float = paddle.movement.ball_maneuver
@onready var original_speed_effectiveness:float = paddle.movement.speed_effectiveness

var active_effects:Array[SlownessEffect] = []
var recharging:bool = false

var effect_active:bool = false :
	set(value):
		effect_active = value
		var tween := create_tween()
		if effect_active:
			paddle.movement.ball_maneuver = slowed_ball_maneuver
			paddle.movement.speed_effectiveness = slowed_speed_effectiveness
			spring_tween(tween, icon_fg, "modulate", active_color)
		else:
			paddle.movement.ball_maneuver = original_ball_maneuver
			paddle.movement.speed_effectiveness = original_speed_effectiveness
			spring_tween(tween, icon_fg, "modulate", original_fg_color)

#=====================================================================#

func spring_tween(tween:Tween, object:Object, property:NodePath, final_val:Variant):
	tween \
		.parallel() \
		.tween_property(object, property, final_val, animation_duration) \
		.set_ease(Tween.EASE_IN) \
		.set_trans(Tween.TRANS_SPRING)

func toggle_effect(balls:Array[BallNode], state:bool):
	if state and not effect_active:
		# Give effects
		for ball in balls:
			var effect:SlownessEffect = SlownessEffect.new(paddle)
			effect.speed_effectiveness = effect_speed_effectiveness
			effect.give(ball)
			effect.ended.connect(active_effects.erase.bind(effect))
			active_effects.append(effect)
	elif not state and effect_active:
		# Remove effects
		for effect in active_effects:
			effect.clear()

	effect_active = state

#=====================================================================#

func on_start() -> void:
	var balls := game.balls

	if recharging:
		toggle_effect(balls, false)
		return

	var tween1 := create_tween()
	spring_tween(tween1, icon_fg, "rotation", 4*PI)
	spring_tween(tween1, icon_bg, "rotation", -2*PI)

	toggle_effect(balls, true)

	recharging = true
	recharge_timer.start()
	await recharge_timer.timeout
	recharging = false

	var tween2 := create_tween()
	spring_tween(tween2, icon_fg, "rotation", 0)
	spring_tween(tween2, icon_bg, "rotation", 0)

	toggle_effect(balls, false)

#=====================================================================#

func _process(delta:float) -> void:
	super._process(delta)
	effect_timer.paused = not game.running
	recharge_timer.paused = not game.running

	if recharging:
		icon_fg.rotation = lerp(0.0, 2*PI, 1 - (recharge_timer.time_left / recharge_timer.wait_time))
