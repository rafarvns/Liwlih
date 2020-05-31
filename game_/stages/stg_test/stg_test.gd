extends Node2D

export var random_enemy_spawn_rate = 1
var can_spawn_random_enemy = true

var enemy_ooze = preload("res://characters/enemy_ooze/enemy_ooze.tscn")
var enemy_giel = preload("res://characters/enemy_giel/enemy_giel.tscn")

func _process(delta):
	spawn_an_enemy()

func spawn_an_enemy():
	
	if can_spawn_random_enemy:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		
		var index_enemy = rng.randi_range(1, 2)
		if index_enemy == 1:
			var start_on_left = rng.randi_range(1, 2)
			spawn_enemy_ooze(true, start_on_left)
			spawn_enemy_ooze(false, start_on_left)
		#elif index_enemy == 2:
			#enemy = enemy_giel.instance()
		#else:
			#enemy = enemy_ooze.instance()
		
		can_spawn_random_enemy = false
		yield(get_tree().create_timer(random_enemy_spawn_rate), "timeout")
		can_spawn_random_enemy = true

func spawn_enemy_ooze(start_on_top, start_on_left):
	var enemy = enemy_ooze.instance()
	var origin = Vector2()
	
	if(start_on_top):
		origin.y = -150
		enemy.destiny_y = 750
	else:
		origin.y = 750
		enemy.destiny_y = -150
	if(start_on_left == 2):
		origin.x = get_viewport().size.x
		enemy.destiny_x = get_viewport().size.x
		enemy.direction = 1
	else:
		origin.x = 0
		enemy.destiny_x = 0
		enemy.direction = -1
	enemy.position = origin
	get_tree().get_root().add_child(enemy)











