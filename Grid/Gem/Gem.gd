tool

extends TextureRect

export(Vector2) var coords setget set_coords, get_coords

enum Types { Ruby, Sapphire, Emerald }
export(Types) var type

signal gem_selected(gem)


func set_coords(pos: Vector2) -> void:
	rect_position = pos * 128


func get_coords() -> Vector2:
	return rect_position / 128


func set_highlight(highlighted: bool) -> void:
	$Offset/Highlight.visible = highlighted


func check_matches() -> bool:
	var neighbour_up = $Offset/Area2D/RayCastUp.get_collider()
	var neighbour_down = $Offset/Area2D/RayCastDown.get_collider()
	if neighbour_up != null and neighbour_down != null:
		var gem_up = neighbour_up.find_parent("Gem*")
		var gem_down = neighbour_down.find_parent("Gem*")
		if gem_up.type == self.type and gem_down.type == self.type:
			return true

	var neighbour_left = $Offset/Area2D/RayCastLeft.get_collider()
	var neighbour_right = $Offset/Area2D/RayCastRight.get_collider()
	if neighbour_left != null and neighbour_right != null:
		var gem_left = neighbour_left.find_parent("Gem*")
		var gem_right = neighbour_right.find_parent("Gem*")
		if gem_left.type == self.type and gem_right.type == self.type:
			return true

	return false


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_select"):
		emit_signal("gem_selected", self)


#func _ready() -> void:
#	$Offset/Area2D/RayCastUp.add_exception(self)