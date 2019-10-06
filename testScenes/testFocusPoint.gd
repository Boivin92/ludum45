extends Node2D

signal transition_completed()

var must_transition := false
var step : int = 0

func _ready() -> void:
	$DialogBox.text = poems[step]
	step += 1
	
export(Array, String, MULTILINE) var poems = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_play_transition"):
		$AnimationPlayer.play("transition" + str(step))

func start_new_game():
	#¯\_(ツ)_/¯
	pass

func transition_to_next():
	$AnimationPlayer.play("transition" + str(step))

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if step == poems.size():
		start_new_game()
		return
	
	$DialogBox.bbcode_text = poems[step]
	step += 1

func _on_Grid_matched(match_info) -> void:
	print("Count:" + str(match_info.count) + "Cascades:" + str(match_info.cascade))
	if match_info.count > 1 or match_info.cascade > 2:
		must_transition = true

func _on_Grid_cascade_finished() -> void:
	if must_transition:
		transition_to_next()
		must_transition = false
