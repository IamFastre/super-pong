class_name Component extends Node

@export var custom_parent:Node
@onready var parent = custom_parent if custom_parent else get_parent()
