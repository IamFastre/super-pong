extends Control

@export var game:GameMode

@export_group("Left", "left_")
@export var left_parent:Node2D
@export var left_up:TouchScreenButton
@export var left_ability:TouchScreenButton
@export var left_down:TouchScreenButton

@export_group("Right", "right_")
@export var right_parent:Node2D
@export var right_up:TouchScreenButton
@export var right_ability:TouchScreenButton
@export var right_down:TouchScreenButton

@onready var pause_button:Button = $PauseButton

func _ready() -> void:
	visible = Utilities.has_touch_screen
	pause_button.pressed.connect(game.pause)

	if game.left_info.is_human:
		left_up.action      = "p%s_up" % game.left_info.mode
		left_ability.action = "p%s_ability" % game.left_info.mode
		left_down.action    = "p%s_down" % game.left_info.mode
	else:
		left_parent.visible = false

	if game.right_info.is_human:
		right_up.action      = "p%s_up" % game.right_info.mode
		right_ability.action = "p%s_ability" % game.right_info.mode
		right_down.action    = "p%s_down" % game.right_info.mode
	else:
		right_parent.visible = false
