extends StaticBody2D
onready var collision_sprite = $collision_sprite
onready var collision_shape = $collision_shape
func activate():
	collision_sprite.visible = false
	collision_shape.disabled = true
