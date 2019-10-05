extends Node2D

signal moved

func set_pos(position : Vector2):
	self.global_position = position

func move_to(position : Vector2):
	$Tween.interpolate_property(self, "global_position", self.global_position, position, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed() -> void:
	emit_signal("moved")
	$Tween.remove_all()