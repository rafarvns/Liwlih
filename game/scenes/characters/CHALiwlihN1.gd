extends KinematicBody2D

export (int) var speed = 700

var velocity = Vector2()
var screen_size
var shoot = preload("res://scenes/guns/GUNHot.tscn")
var can_shoot = true
var rate_of_shoot = 0.1

func get_input():
	screen_size = get_viewport_rect().size
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func shoot_loop():
	if Input.is_action_pressed("ui_shot") and can_shoot == true:
		can_shoot = false
		var shoot_instance = shoot.instance()
		var pos = get_global_position()
		pos.y -= 12
		pos.x += 12
		shoot_instance.position = pos
		get_parent().add_child(shoot_instance)
		yield(get_tree().create_timer(rate_of_shoot), "timeout")
		can_shoot = true

func _process(delta):
	shoot_loop()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
