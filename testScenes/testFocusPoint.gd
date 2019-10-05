extends Node2D

signal transition_completed()

func _ready() -> void:
	$DialogBox.text = poems[step]
	step += 1
	
var step : int = 0
export(Array, String, MULTILINE) var poems = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("transition" + str(step))

func start_new_game():
	emit_signal("transition_completed")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$DialogBox.text = poems[step]
	step += 1