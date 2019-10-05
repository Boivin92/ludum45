tool
extends Control

func _ready():
	
	pass

func _on_StartGame_pressed() -> void:
	get_tree().change_scene("res://Scenes/Game.tscn")
	pass 
