extends AudioStreamPlayer

export(AudioStream) var regular : AudioStream
export(AudioStream) var success : AudioStream

func _ready():
	pass

func play_match():
	stream = regular
	play()

func play_success():
	stream = success
	play()

func _on_Grid_matched(match_info) -> void:
	if match_info.has_type(match_info.Types.Gear):
		play_success()
	else:
		play_match()


func _on_Grid_no_moves_left() -> void:
	pass # Replace with function body.
