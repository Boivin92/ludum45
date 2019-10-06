extends AnimatedSprite

func _ready():
	pass



func _on_Grid_matched(match_info) -> void:
	if not playing:
		rotation_degrees = rand_range(0,360)
		play()


func _on_BackgroundAnimation_animation_finished() -> void:
	frame = 0
	playing = false
