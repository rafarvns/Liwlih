extends AnimatedSprite

func _on_anim_player_bullet_explosion_animation_finished():
	queue_free()
