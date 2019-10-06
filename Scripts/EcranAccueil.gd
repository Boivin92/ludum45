tool
extends Control

func _ready():
	
	pass

func _on_StartGame_pressed() -> void:
	get_tree().change_scene("res://testScenes/testFocusPoint.tscn")
	pass 


func _on_Infos_pressed() -> void:
	get_tree().change_scene("res://Scenes/HowTo.tscn")
	pass 
