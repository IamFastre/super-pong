extends Control

@export var game:GameMode

@export_group("Left", "left_")
@export var left_parent:Node2D
@export var left_up:TouchScreenButton
@export var left_ability:TouchScreenButton
@export var left_down:TouchScreenButton
@export var left_ability_icon:TextureRect

@export_group("Right", "right_")
@export var right_parent:Node2D
@export var right_up:TouchScreenButton
@export var right_ability:TouchScreenButton
@export var right_down:TouchScreenButton
@export var right_ability_icon:TextureRect

@onready var pause_button:Button = $PauseButton

func _ready() -> void:
	await game.ready
	visible = Utilities.has_touch_screen
	pause_button.pressed.connect(game.pause)

	if game.left_info.is_human:
		left_up.action      = "p%s_up" % game.left_info.mode
		left_ability.action = "p%s_ability" % game.left_info.mode
		left_down.action    = "p%s_down" % game.left_info.mode
		var icon := game.left_paddle.get_node("Icon") as TextureRect
		if icon: left_ability_icon.texture = icon.texture

	else:
		left_parent.visible = false

	if game.right_info.is_human:
		right_up.action      = "p%s_up" % game.right_info.mode
		right_ability.action = "p%s_ability" % game.right_info.mode
		right_down.action    = "p%s_down" % game.right_info.mode
		var icon := game.right_paddle.get_node("Icon") as TextureRect
		if icon: right_ability_icon.texture = icon.texture
	else:
		right_parent.visible = false
