extends Light2D

func set_wait(time : float):
	$Timer.wait_time = time
	$Timer.start()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()

func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("flash")
