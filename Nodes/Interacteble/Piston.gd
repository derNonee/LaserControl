extends StaticBody2D

func activate():
	$AnimationPlayer.play("open")
	$AudioStreamPlayer2D.play()
	$CollisionShape2D.position.y = 3
	var timer = Timer.new()
	add_child(timer, true)
	timer.start(3)
	yield(timer, "timeout")
	timer.queue_free()
	$CollisionShape2D.position.y = 0
	$AnimationPlayer.play_backwards("open")
