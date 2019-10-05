extends Node2D

signal transition_completed()

func _ready() -> void:
	$DialogBox.text = poems[step]
	step += 1
	
var step : int = 0
export(Array, String, MULTILINE) var poems = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_play_transition"):
		$AnimationPlayer.play("transition" + str(step))

func start_new_game():
	$GameScreen/Grid.reset_grid()

func transition_to_next():
	$AnimationPlayer.play("transition" + str(step))

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if step <= poems.size():
		start_new_game()
		return
	
	$DialogBox.bbcode_text = poems[step]
	step += 1