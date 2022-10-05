extends Node2D



func activate():
	if [] != $Area2D.get_overlapping_bodies():
		for i_ in $Area2D.get_overlapping_bodies():
			if i_.name != "Player":
				for i in get_children():
					if i.is_in_group("Active") and i.name != "Player":
						get_node(i.name).activate()
