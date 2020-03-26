extends RigidBody2D

var shoot_speed = 1000

func _ready():
	apply_impulse(Vector2(), Vector2(shoot_speed, 0))
