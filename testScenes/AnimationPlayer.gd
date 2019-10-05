extends AnimationPlayer

func _ready():
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		playback_speed = 5
	else:
		playback_speed = 1