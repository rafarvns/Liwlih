extends Control

export var life_stunner = 100
export var life_skycut = 100
export var life_smoke = 100
export var score_points = 0

func _process(delta):
	$life_bar_stunner.value = life_stunner
	$life_bar_skycut.value = life_skycut
	$life_bar_smoke.value = life_smoke
	$lbl_score_points.text = String(score_points)
