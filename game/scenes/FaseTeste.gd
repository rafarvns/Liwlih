extends Node2D

var rate_of_enemies = 1
var ooze = preload("res://scenes/characters/Ooze.tscn")
var make_a_ooze = false
var ooze_count = 0
var fps = 0

func _process(delta):
	enemies_loop()

func enemies_loop():
	
	ooze_loop()
	
	if fps >= 300:
		make_a_ooze = true
		fps = 0	
	fps += 1

func ooze_loop():
	if make_a_ooze == true:
		var ooze_instance = ooze.instance()
		var ooze_pos = Vector2()
		ooze_pos.x = 1300
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		ooze_pos.y = rng.randf_range(40, 600)
		ooze_instance.position = ooze_pos
		get_parent().add_child(ooze_instance)
		make_a_ooze = false
