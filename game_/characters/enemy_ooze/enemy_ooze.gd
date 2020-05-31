extends KinematicBody2D

var death_explosion = preload("res://characters/enemy_ooze/anim_oozy_explosion.tscn")
var bullet = preload("res://characters/enemy_ooze/bul_enemy_ooze.tscn")
var life = 100
var destiny_y = -150
var destiny_x = 0
var speed = 250
var can_fire = true
var fire_rate = 0.5
var min_destiny_x = -50
var max_destiny_x = 0
var direction = 1

func _ready():
	if(direction == -1):
		$".".rotation_degrees = 180
	max_destiny_x = get_viewport().size.x + 50

func _process(delta):
	fire()
	if life <= 0:
		print(get_tree().get_root().get_node("stg_test").get_node("interface").name)
		var interface = get_tree().get_root().get_node("stg_test").get_node("interface")
		interface.score_points += 200
		var explosion_instance = death_explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
	var destiny = Vector2(destiny_x, destiny_y)
	var dir = (destiny - global_position).normalized()
	var col = move_and_collide(dir*speed*delta)

	if(get_global_position().y >= destiny_y && get_global_position().y >= 650):
		destiny_y = -50
		destiny_x -= 5 * direction
	elif(get_global_position().y <= destiny_y && get_global_position().y <= -50):
		destiny_y = 650
		destiny_x -= 5 * direction
	if(get_global_position().x <= min_destiny_x):
		queue_free()


func fire():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $bullet_pos_ooze_1.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.direction = direction
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var r = rng.randf_range(-0.2, 0.2)
		bullet_instance.direction = Vector2(direction * -1, r)
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func _on_body_body_entered(body):
	if body.is_in_group("player"):
		life = 0
		body.add_damage(20)
