extends Node2D
onready var raycast = $RayCast2D
onready var laser_texture = $Sprite
onready var laser_running = $laser_running
var already_checked = false
func _ready():
	laser_texture.visible = true
	raycast.enabled = true
func activate():
	already_checked = false
	check_colider()

func _physics_process(delta):
	laser_running.play()
	var scale_ = raycast.get_collision_point()-position
	$Sprite.scale.y = -scale_.y
	$Sprite.position.y = -scale_.y
	
func check_colider():
	if raycast.get_collider() == get_node("Reciever"):
		for i in get_node("Reciever").get_children():
			if i.is_in_group("Active"):
				get_node("Reciever/"+i.name).activate()
	var timer = Timer.new()
	timer.connect("timeout", self, "timeout")
	add_child(timer, true)
	timer.start(2)
		

func timeout():
	laser_running.stop()
	get_node("Timer").queue_free()
	laser_texture.visible = false
	raycast.enabled = false
	set_physics_process(false)
