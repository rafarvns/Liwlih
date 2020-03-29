extends KinematicBody2D

var hp = 200
var oozy_speed = 500
var velocity = Vector2()
var is_enter = true
var direction = true
var destiny = 0

func _ready():
	velocity = Vector2()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	destiny = rng.randf_range(300, 1100)
	oozy_speed = rng.randf_range(80, 150)
	
func _process(delta):
	
	if hp <= 0:
		queue_free()
	
	shoot()
	ia_movement()

func shoot():
	print(hp)

func ia_movement():
	var pos = get_global_position()
	if pos.x > destiny:
		velocity.x -= 1
	else:
		velocity.x = 0		
		if direction == true:
			velocity.y -= 1
			if pos.y < 40:
				direction = false
				velocity.y = 0
		else:
			velocity.y += 1
			if pos.y > 600:
				direction = true
				velocity.y = 0
				
	velocity = velocity.normalized() * oozy_speed
	velocity = move_and_slide(velocity)
