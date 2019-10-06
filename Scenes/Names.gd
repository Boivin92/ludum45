extends Label

var counter = 0

func _ready() -> void:
	pass
	
func _next_name(names):
	if (counter < names.size()):
		text = names[counter]
		print(text)
		counter += 1
#	else:
#		counter = 0
#		text = names[counter]
#		counter += 1
	

