class_name SlownessEffect extends BallEffect

@export var speed_effectiveness := 0.5

#=====================================================================#

func on_start() -> void:
	ball.speed_effectiveness *= speed_effectiveness

func on_finish() -> void:
	ball.speed_effectiveness /= speed_effectiveness
