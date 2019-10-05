tool
extends Node

func _ready() -> void:
#	for i in range (900, 0, -50):
#		$ScrollCredits/Credits.position.y=i
#	$ScrollCredits/Credits/AnimationPlayer.play("fade")
	pass


func _on_RetourAccueil_pressed() -> void:
	get_tree().change_scene("res://Scenes/EcranAccueil.tscn")
	pass 
