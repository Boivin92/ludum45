extends Node2D

func _ready() -> void:
	for i in $Tapisserie.steps.size():
		$Tapisserie.show_step(i)
	pass
	
	
	
