extends KinematicBody2D

export var speed = 200
export var bullet_speed = 1000
export var bullet_damage = 35
export var fire_rate = 0.04
export var change_ship_rate = 1
export var life = 100
export var life_stunner = 100
export var life_skycut = 100
export var life_smoke = 100


var stunner = preload("res://characters/player_liwlih/spt_stunner.png")
var skycut = preload("res://characters/player_liwlih/spt_skycut.png")
var smoke = preload("res://characters/player_liwlih/spt_smoke.png")
var bullet = preload("res://characters/player_liwlih/bul_skycut.tscn")
var bullet_stunner = preload("res://characters/player_liwlih/spt_bul_stunner.png")
var bullet_skycut = preload("res://characters/player_liwlih/spt_bul_skycut.png")
var bullet_smoke = preload("res://characters/player_liwlih/spt_bul_smoke.png")
var bullet_texture = bullet_stunner
var can_fire = true
var can_change_ship = true
var actual_ship = 1

func _ready():
	pass

func _process(delta):
	look_at(get_global_mouse_position())
	fire()
	change_ship()
	update_interface()

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("move_up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		direction += Vector2(1, 0)
	move_and_slide(direction * speed)

func fire():
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.get_child(1).texture = bullet_texture
		bullet_instance.position = $bullet_pos_skycut.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.damage = bullet_damage
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func change_ship():
	if Input.is_action_pressed("change_ship") and can_change_ship:
		actual_ship += 1
		if actual_ship == 4:
			actual_ship = 1
		
		if actual_ship == 1:
			$sprite.texture = stunner
			$stunner_fire.visible = true
			$skycut_fire.visible = false
			$smoke_fire.visible = false
			bullet_texture = bullet_stunner
			bullet_speed = 1400
			bullet_damage = 28
			speed = 250
			life_smoke = life
			life = life_stunner
		elif actual_ship == 2:
			$sprite.texture = skycut
			$skycut_fire.visible = true
			$stunner_fire.visible = false
			$smoke_fire.visible = false
			bullet_texture = bullet_skycut
			bullet_speed = 1600
			bullet_damage = 24
			speed = 350
			life_stunner = life
			life = life_skycut
		elif actual_ship == 3:
			$sprite.texture = smoke
			$smoke_fire.visible = true
			$skycut_fire.visible = false
			$stunner_fire.visible = false
			bullet_texture = bullet_smoke
			bullet_speed = 1300
			bullet_damage = 30
			speed = 200
			life_skycut = life
			life = life_smoke
		
		can_change_ship = false
		yield(get_tree().create_timer(change_ship_rate), "timeout")
		can_change_ship = true

func update_interface():
	var interface = $"../interface"
	if(actual_ship == 1):
		interface.life_stunner = life
	elif(actual_ship == 2):
		interface.life_skycut = life
	elif(actual_ship == 3):
		interface.life_smoke = life
