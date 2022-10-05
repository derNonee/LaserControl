extends Node2D



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().get_root().get_node("Game").level_finished()
