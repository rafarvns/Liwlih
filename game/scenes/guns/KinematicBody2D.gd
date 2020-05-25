extends KinematicBody2D

var shoot_speed = 1000
var velocity = Vector2()

func _ready():
	velocity = Vector2()

func _process(delta):
	velocity.x += 1
	velocity = velocity.normalized() * shoot_speed
	move_and_slide(velocity)
