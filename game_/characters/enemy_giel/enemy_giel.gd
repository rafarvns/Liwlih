extends RigidBody2D

var death_explosion = preload("res://characters/enemy_ooze/anim_oozy_explosion.tscn")
var life = 100

func _process(delta):
	if life <= 0:
		var explosion_instance = death_explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()

func _ready():
	pass # Replace with function body.

func _on_enemy_giel_body_entered(body):
	print(body)
	pass # Replace with function body.
