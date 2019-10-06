tool

extends TextureRect

#warning-ignore:unused_class_variable
export(Vector2) var coords setget set_coords, get_coords

export(MatchInfo.Types) var type

enum FallTypes { Regular, Spawn }

signal gem_selected(gem)

var to_remove := false


func set_coords(pos: Vector2) -> void:
	rect_position = pos * 128


func get_coords() -> Vector2:
	return rect_position / 128


func set_highlight(highlighted: bool) -> void:
	$Offset/Highlight.visible = highlighted


func check_matches() -> bool:
	if type == MatchInfo.Types.None:
		return false

	var is_match_center := false
	var neighbour_up = $Offset/Area2D/RayCastUp.get_collider()
	var neighbour_down = $Offset/Area2D/RayCastDown.get_collider()
	if neighbour_up != null and neighbour_down != null:
		var gem_up = neighbour_up.find_parent("Gem*")
		var gem_down = neighbour_down.find_parent("Gem*")
		if gem_up.type == self.type and gem_down.type == self.type:
			to_remove = true
			is_match_center = true
			gem_up.to_remove = true
			gem_down.to_remove = true

	var neighbour_left = $Offset/Area2D/RayCastLeft.get_collider()
	var neighbour_right = $Offset/Area2D/RayCastRight.get_collider()
	if neighbour_left != null and neighbour_right != null:
		var gem_left = neighbour_left.find_parent("Gem*")
		var gem_right = neighbour_right.find_parent("Gem*")
		if gem_left.type == self.type and gem_right.type == self.type:
			to_remove = true
			is_match_center = true
			gem_left.to_remove = true
			gem_right.to_remove = true

	return is_match_center


func move_to(new_coords: Vector2, tween: Tween) -> void:
	tween.interpolate_property(self, "coords",
			get_coords(), new_coords, 0.5,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func set_fall(distance: int, fall_type: int, tween: Tween) -> void:
	if distance == 0:
		return
	var old_coords := get_coords()
	var new_coords := old_coords + distance * Vector2(0, 1)
	tween.interpolate_property(self, "coords",
			old_coords, new_coords, 0.6,
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	if fall_type == FallTypes.Spawn:
		tween.interpolate_property(self, "modulate",
				Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.6,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_select"):
		emit_signal("gem_selected", self)
		
		
		
		
onready var patterns = [[$Offset/Area2D/RayCastDown, $Offset/Area2D/RayCastUpLeft, $Offset/Area2D/RayCastUpRight],
						[$Offset/Area2D/RayCastUp, $Offset/Area2D/RayCastDownLeft, $Offset/Area2D/RayCastDownRight],
						[$Offset/Area2D/RayCastLeft, $Offset/Area2D/RayCastUpRight, $Offset/Area2D/RayCastDownRight],
						[$Offset/Area2D/RayCastRight, $Offset/Area2D/RayCastUpLeft, $Offset/Area2D/RayCastDownLeft],]
						
func is_match_possible() -> bool:
	for pattern in patterns:
		var matching_type_counter = 0
		for raycast in pattern:
			var collision = raycast.get_collider()
			if collision:
				if collision.find_parent("Gem*").type == self.type:
					matching_type_counter += 1
		if matching_type_counter >= 2:
			return true
	return false