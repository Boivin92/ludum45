extends Node2D

const NOT_VISIBLE = Color(1,1,1,0)
const VISIBLE = Color(1,1,1,1)

var steps = []

func _ready():
	steps = $fragments.get_children()
	for sprite in steps:
		sprite.self_modulate = NOT_VISIBLE

func show_step(step : int):
	var sprite = steps[step] as Sprite
	$Tween.interpolate_property(sprite, "self_modulate", sprite.self_modulate, VISIBLE, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed() -> void:
	$Tween.remove_all()