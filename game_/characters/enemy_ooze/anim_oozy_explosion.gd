extends AnimatedSprite

func _on_anim_oozy_explosion_animation_finished():
	queue_free()
