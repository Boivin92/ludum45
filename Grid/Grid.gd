extends Node2D

export(int, 3, 12) var height = 3
export(int, 3, 12) var width = 3

var selected = null

func is_adjacent(coord: Vector2) -> bool:
	if selected == null:
		return false
	var delta = (coord - selected).abs()
	var distance_ortho = delta.x + delta.y
	return distance_ortho == 1

func _on_gem_selected(gem) -> void:
	if selected == null:
		selected = gem.get_coords()
		gem.set_highlight(true)
	elif is_adjacent(gem.get_coords()):
		print("swap!")
	else:
		selected = null
		gem.set_highlight(false)
