tool
extends Label

var names = ["François Boivin", "Ariane Simard-Leduc", "Marie-Pierre Bergeron", "Olivier Boily", "Cédric Pinard", "Mélanie Ellias"]
var counter = 0

func _ready() -> void:
	pass
	
func next_credits():
	if (counter < names.size()):
		$Names.text = names[counter]
		counter += 1
	else:
		counter = 0
	

