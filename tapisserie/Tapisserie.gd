extends Node2D

const NOT_VISIBLE = Color(1,1,1,0)
const VISIBLE = Color(1,1,1,1)

var steps
var current_step : int = 0 

signal ended

func _ready():
	steps = $fragments.get_children()
	for sprite in steps:
		sprite.self_modulate = NOT_VISIBLE
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		show_current_step()

func get_next_step_position():
	current_step += 1
	if steps.size() >= current_step:
		emit_signal("ended")
		return
	return steps[current_step].global_position

func show_current_step():
	show_step(steps[current_step])

func show_step(step : Sprite):
	$Tween.interpolate_property(step, "self_modulate", step.self_modulate, VISIBLE, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed() -> void:
	$Tween.remove_all()
