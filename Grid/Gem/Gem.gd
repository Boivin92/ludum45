tool

extends TextureRect

export(Vector2) var coords setget set_coords, get_coords

signal gem_selected(gem)


func set_coords(pos: Vector2) -> void:
	rect_position = pos * 128


func get_coords() -> Vector2:
	return rect_position / 128


func set_highlight(highlighted: bool) -> void:
	$Highlight.visible = highlighted

func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("ui_select"):
		emit_signal("gem_selected", self)