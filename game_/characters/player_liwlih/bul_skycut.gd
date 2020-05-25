extends RigidBody2D

var explosion = preload("res://characters/player_liwlih/anim_player_bullet_explosion.tscn")

var damage = 35

func _process(delta):
	var position = $".".position
	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y
	
	if position.x >= screen_width + 50 || position.x < -50:
		queue_free()
	elif position.y >= screen_height + 50 || position.y < -50:
		queue_free()


func _on_bullet_default_body_entered(body):
	if body.is_in_group("enemy"):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		body.life -= damage
		queue_free()
