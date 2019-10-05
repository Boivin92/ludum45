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