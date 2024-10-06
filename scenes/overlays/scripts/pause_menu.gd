class_name PauseScreen extends CanvasLayer

@export var game:GameMode
@export var animation:AnimationPlayer

@export_group("Extra")
@export var is_super:bool = false
@export var suptitle:Label

var dying:bool = false

func _on_death_animation_finished(_s:StringName):
	queue_free()

func _on_continue_pressed() -> void:
	if game and is_instance_valid(game):
		game.unpause()
	dying = true
	animation.animation_finished.connect(_on_death_animation_finished)
	animation.play("start", -1, -2, true)

func _on_restart_pressed() -> void:
	if game and is_instance_valid(game):
		game.restart()
	dying = true
	animation.animation_finished.connect(_on_death_animation_finished)
	animation.play_backwards("start")

func _on_exit_pressed() -> void:
	SceneManager.switch(SceneManager.Scene.MainMenu)

#=====================================================================#

func _ready() -> void:
	animation.play("start")
	suptitle.visible = is_super

func _process(_delta:float) -> void:
	if game and is_instance_valid(game):
		if game.running and not dying:
			dying = true
			_on_continue_pressed()
