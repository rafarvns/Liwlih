extends KinematicBody2D

var shoot_speed = 600
var velocity = Vector2()
var direction = true

func _ready():
	velocity = Vector2()
	direction = get_node("../../Ooze").direction
	
func _process(delta):
	velocity.x -= 1
	if(direction == true):
		velocity.y -= 0.5
	else:
		velocity.y += 0.5
		
	velocity = velocity.normalized() * shoot_speed
	move_and_slide(velocity)


func set_direction(value):
	direction = value
