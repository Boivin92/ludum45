extends Node2D

func _ready() -> void:
	pass

func _on_RetourAccueil_pressed() -> void:
	get_tree().change_scene("res://Scenes/EcranAccueil.tscn")
	pass 

func _on_Credits_pressed() -> void:
	get_tree().change_scene("res://Scenes/Credits.tscn")
	pass
