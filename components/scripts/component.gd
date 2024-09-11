class_name ComponentNode extends Node

@export var custom_parent:Node2D
@onready var parent = custom_parent if custom_parent else get_parent() as Node2D
