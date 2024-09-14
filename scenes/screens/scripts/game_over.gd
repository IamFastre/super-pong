@tool
class_name GameOverScreen extends CanvasLayer

@export var game:ClassicGame
@export var animation:AnimationPlayer

@export_group("Scores", "score_")
@export var score_left:int = 0
@export var score_right:int = 0
@export var score_is_tied:bool = false

@export_group("Winner", "winner_")
@export var winner_name:String = "Player"
@export var winner_side:String = "Side"

@export_group("Labels", "label_")
@export var label_title:Label
@export var label_subtitle:Label
@export var label_suptitle:Label

#=====================================================================#

func set_texts() -> void:
	if not score_is_tied:
		label_title.text = "%s won!" % winner_name
		label_subtitle.text = "(%s)" % winner_side
		label_suptitle.text = "%s - %s" % [str(score_left), str(score_right)]
	else:
		label_title.text = "It's a tie!"
		label_subtitle.text = "(no one won)"
		label_suptitle.text = "%s - %s" % [str(score_left), str(score_right)]

#=====================================================================#

func _on_death_animation_finished(_s:StringName):
	queue_free()

func _on_home_pressed() -> void:
	SceneManager.switch(SceneManager.Scene.MainMenu)

func _on_retry_pressed() -> void:
	if game and is_instance_valid(game):
		game.restart()
	animation.animation_finished.connect(_on_death_animation_finished)
	animation.play_backwards("start")

#=====================================================================#

func _ready() -> void:
	set_texts()
	animation.play("start")

func _process(_delta:float) -> void:
	set_texts()
