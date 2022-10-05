extends Node2D
var level_count = 5
var courent_level = 1
var courrent_activation = 0
var made_it_to_door= false
var level
var player

func spawn_level(level_id):
	level=load("res://Nodes/Map/Level"+str(level_id)+"/Level.tscn").instance()
	add_child(level, true)
	player = load("res://Nodes/enteties/Player.tscn").instance()
	player.position = level.get_node("Spawn").position
	add_child(player, true)
	add_audio_player()
	game_cycel()

func game_cycel():
	while !level.max_activations < courrent_activation-1:
		for i in range(1,11):
			level.name= "Level"
			player.name = "Player"
			var timer = Timer.new()
			add_child(timer, true)
			timer.start(1)
			yield(timer, "timeout")
			timer.queue_free()
			player.get_node("Cam/Control/Time_left").text = "Time left: "+ str(10 - i)
		if !level.max_activations < courrent_activation:
			made_it_to_door=false
			level.get_node("active").get_child(courrent_activation).activate()
		courrent_activation += 1
	if !made_it_to_door:
		courrent_activation = 0
		failed()

func level_finished():
	made_it_to_door = true
	courrent_activation = 0
	for i in get_children():
		get_node(i.name).queue_free()
	if !courent_level >= level_count:
		courent_level += 1
		call_deferred("spawn_level",courent_level)
	else:
		get_tree().get_root().add_child(load("res://Nodes/UI/Won_menu.tscn").instance())
		queue_free()

func failed():
	var failed_menu = preload("res://Nodes/UI/Failed_menu.tscn").instance()
	courrent_activation = 0
	for i in get_children():
		get_node(i.name).queue_free()
	add_child(failed_menu)

func add_audio_player():
	var audioplayer = AudioStreamPlayer.new()
	var music = load("res://Assets/Music/why is it always me (music) (1).mp3")
	audioplayer.stream = music
	audioplayer.autoplay = true
	add_child(audioplayer)
