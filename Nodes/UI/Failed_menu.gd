extends Control

var menu = load("res://Nodes/UI/Menu.tscn").instance()
func _ready():
	get_parent().get_node("Player").queue_free()
	get_parent().get_node("Level").queue_free()
func _on_Try_again_pressed():
	get_parent().spawn_level(get_parent().courent_level)
	queue_free()


func _on_Exit_pressed():
	get_tree().get_root().add_child(menu)
	get_parent().queue_free()
