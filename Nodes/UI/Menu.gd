extends Control

var game = load("res://Nodes/Game.tscn").instance()

func _on_Play_pressed():
	get_tree().get_root().add_child(game)
	game.spawn_level(3)
	queue_free()


func _on_Exit_pressed():
	get_tree().quit()
