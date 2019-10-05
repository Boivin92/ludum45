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
	if match_info.count == 1:
		play_match()
	else:
		play_success()
