tool
extends Label

export(String) var texte setget set_label, get_label_texte

	
func set_label(value):
		text=value
		
func get_label_texte():
		return text

