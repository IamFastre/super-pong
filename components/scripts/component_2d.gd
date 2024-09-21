class_name ComponentNode2D extends Node2D

@export var custom_parent:Node
@onready var parent = custom_parent if custom_parent else get_parent()
