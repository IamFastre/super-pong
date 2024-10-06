class_name SuperGame extends GameMode

func on_ball_spawned(ball:BallNode):
	ball.particles.visible = true

#=====================================================================#

func _ready() -> void:
	ball_spawned.connect(on_ball_spawned)
	super._ready()

func _process(delta:float) -> void:
	super._process(delta)
