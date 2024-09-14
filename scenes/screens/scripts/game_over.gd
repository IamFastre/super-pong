@tool
class_name GameOverScreen extends CanvasLayer

@export var game:ClassicGame
@export var animation:AnimationPlayer

@export_group("Scores", "score_")
@export var score_left:int = 0
@export var score_right:int = 0

@export_group("Winner", "winner_")
@export var winner_name:String = "Player"
@export var winner_side:String = "Side"

@export_group("Labels", "label_")
@export var label_title:Label
@export var label_subtitle:Label
@export var label_suptitle:Label

#=====================================================================#

func set_texts() -> void:
	label_title.text = "%s won!" % winner_name
	label_subtitle.text = "(%s)" % winner_side
	label_suptitle.text = "%s - %s" % [str(score_left), str(score_right)]

#=====================================================================#

func _on_home_pressed() -> void:
	SceneManager.switch(SceneManager.Scene.MainMenu)

func _on_retry_pressed() -> void:
	game.restart()
	queue_free()

#=====================================================================#

func _ready() -> void:
	set_texts()
	animation.play("start")

func _process(_delta:float) -> void:
	set_texts()
