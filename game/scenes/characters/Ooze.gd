extends KinematicBody2D

var hp = 200
var oozy_speed = 500
var velocity = Vector2()
var is_enter = true
var direction = true
var destiny = 0
var fire_time = 0
var shoot = preload("res://scenes/guns/GUNHotOoze.tscn")
var can_shoot = true
var rate_of_shoot = 0.1
var fps = 0

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
	if fps >= 45:
		can_shoot = true
		fps = 0	
	fps += 1	
	
	if can_shoot == true:
		can_shoot = false
		var shoot_instance = shoot.instance()
		var pos = get_global_position()
		pos.y -= 12
		pos.x -= 12
		shoot_instance.position = pos
		get_parent().add_child(shoot_instance)
		yield(get_tree().create_timer(rate_of_shoot), "timeout")

func ia_movement():
	var pos = get_global_position()
	if pos.x > destiny:
		velocity.x -= 1
		if(pos.x < 1100):
			$Collision.disabled = false
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
