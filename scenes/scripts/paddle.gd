class_name PaddleNode extends StaticBody2D

@export var player_movement:PackedScene = preload('res://components/player_movement.tscn')
@export var ai_movement:PackedScene

func make_human(id:PlayerInfo.ID) -> void:
	var comp := player_movement.instantiate() as PlayerMovement
	comp.id = id
	add_child(comp)

func make_ai(_id:PlayerInfo.ID) -> void:
	pass
	# var comp := ai_movement.instantiate()
	# comp.id = id
	# add_child(comp)

func setup(info:PlayerInfo) -> void:    
	if info.is_human:
		make_human(info.id)
	else:
		make_ai(info.id)
