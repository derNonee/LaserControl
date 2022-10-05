extends KinematicBody2D

const GRAVITY = 120
const MAX_GRAVITY = 170
const MAX_SPEED = 50
const JUMP_POWER = 90
const ACCELERATION = 200
const rigid_push_force = 100
const UP_VECTOR = Vector2.UP
var movement= Vector2(0,0)
var walking=false

onready var animation_player = $AnimationPlayer
onready var sfxwalkplayer = $"sfx walk player"
onready var sfxjumpplayer = $"sfx jump player"


func _ready():
	pass
func _physics_process(delta):
	movement.x = clamp(movement.x,-MAX_SPEED,MAX_SPEED)
	if movement.y < MAX_GRAVITY:
		movement.y += GRAVITY * delta
	else:
		movement.y = MAX_GRAVITY

	if Input.is_action_pressed("Left"):
		movement.x -= ACCELERATION *delta
		animation_player.play("Walk_left")
	elif Input.is_action_pressed("Right"):
		movement.x += ACCELERATION*delta
		animation_player.play("Walk_right")
	else:
		walking = false
		movement.x = lerp(movement.x, 0, 0.2)
		animation_player.play("idle")
		sfxwalkplayer.stop()
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		sfxjumpplayer.play()
		movement.y -= JUMP_POWER

	if is_on_floor() and movement.x != 0 and !walking:
		sfxwalkplayer.play()
		walking= true

	if !is_on_floor():
		animation_player.play("Jump")
		sfxwalkplayer.stop()
		walking = false
	movement = move_and_slide(movement, UP_VECTOR,false, 4, PI/4, false)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if collider.get_parent().name == "Boxes":
			collider.apply_central_impulse(-collision.normal*rigid_push_force)


func _on_Button_pressed():
	get_parent().courrent_activation = 0
	for i in get_parent().get_children():
		get_parent().get_node(i.name).queue_free()
	get_parent().spawn_level(get_parent().courent_level)
