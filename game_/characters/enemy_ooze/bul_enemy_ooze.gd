extends KinematicBody2D

var direction = Vector2()
var speed = 105
var contact_animation = preload("res://characters/player_liwlih/anim_player_bullet_explosion.tscn")

func _process(delta):
	
	move_and_slide(direction * speed)
	
	var position = $".".position
	var screen_width = get_viewport().size.x
	var screen_height = get_viewport().size.y
	
	if position.x >= screen_width + 50 || position.x < -50:
		queue_free()
	elif position.y >= screen_height + 50 || position.y < -50:
		queue_free()




func _on_body_body_entered(body):
	if body.is_in_group("player"):
		var explosion_instance = contact_animation.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		body.add_damage(20)
		queue_free()
