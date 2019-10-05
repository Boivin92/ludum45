extends Node2D

func _ready() -> void:
	$FocusPoint.set_pos($Tapisserie.get_next_step_position())
	$Tapisserie.show_current_step()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var next_position = $Tapisserie.get_next_step_position()
		if next_position:
			$FocusPoint.move_to(next_position)

func _on_FocusPoint_moved() -> void:
	$Tapisserie.show_current_step()
