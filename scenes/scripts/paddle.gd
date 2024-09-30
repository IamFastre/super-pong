class_name PaddleNode extends StaticBody2D

@export_group("Components")
@export var controller:PaddleController
@export var movement:PaddleMovement

func setup_controller(new_controller:PaddleController):
    add_child(new_controller)
    controller = new_controller
    movement.controller = new_controller
