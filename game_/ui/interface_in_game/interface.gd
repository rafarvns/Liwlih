extends Control

export var life = 100

func _process(delta):
	$life_bar.value = life
