class_name BallEffect extends Component2D

@onready var game:GameMode = GameMode.get_instance(parent)
@onready var ball:BallNode = parent

var paddle:PaddleNode
var opponent:PaddleNode

signal ended

#=====================================================================#

func on_start()   -> void: pass
func on_running(_delta:float) -> void: pass
func on_finish()  -> void: pass

func give(effected_ball:BallNode) -> BallEffect:
	effected_ball.add_child(self)
	return self

func clear() -> void:
	queue_free()

#=====================================================================#

func _init(owner_paddle:PaddleNode, opponent_paddle:PaddleNode = null) -> void:
	paddle = owner_paddle
	opponent = opponent_paddle

func _ready() -> void:
	on_start()

func _process(delta:float) -> void:
	on_running(delta)

func _exit_tree() -> void:
	on_finish()
	ended.emit()
