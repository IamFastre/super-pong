class_name GoalNode extends Area2D

signal scored()

func _on_body_entered(body:Node2D) -> void:
	if body is BallNode:
		var ball := body as BallNode
		scored.emit()
		ball.queue_free()
