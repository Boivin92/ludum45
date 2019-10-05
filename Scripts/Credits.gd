extends Node

func _ready() -> void:
	pass


func _on_RetourAccueil_pressed() -> void:
	get_tree().change_scene("res://Scenes/EcranAccueil.tscn")
	pass 
