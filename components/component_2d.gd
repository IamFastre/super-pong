class_name Component2D extends Node2D

@export var custom_parent:Node
@onready var parent = custom_parent if custom_parent else get_parent()
