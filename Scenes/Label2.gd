extends Label

var skills = ["Programming", "Art works","Scenario", "Feeding"]

func _ready() -> void:
	if (counter < names.size()):
		text = names[counter]
		counter += 1
	else:
		counter = 0
		text = names[counter]
		counter += 1
	pass
