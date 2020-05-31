extends KinematicBody2D

var death_explosion = preload("res://characters/enemy_ooze/anim_oozy_explosion.tscn")
var life = 100
var destiny_y = -50
var position_x = 650
var can_push = true
var speed = 400

func _process(delta):
	if life <= 0:
		var explosion_instance = death_explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
	var destiny = Vector2(position_x, destiny_y)
	var dir = (destiny - global_position).normalized()
	var col = move_and_collide(dir*speed*delta)

func _ready():
	pass # Replace with function body.

func _on_body_body_entered(body):
	if body.is_in_group("player"):
		life = 0
		body.add_damage(20)
