extends Node2D

export(int, 3, 12) var height = 3
export(int, 3, 12) var width = 3

var selected = null

func find_gem(coord: Vector2):
	for gem in get_children():
		if gem.coords == coord:
			return gem
	return null

func can_swap(coord1: Vector2, coord2: Vector2) -> bool:
	if selected == null:
		return false
	var delta = (coord1 - coord2).abs()
	var distance_ortho = delta.x + delta.y
	return distance_ortho == 1


func try_swap(gem1, gem2) -> void:
	if not can_swap(gem1.coords, gem2.coords):
		return
	var temp = gem1.coords
	gem1.coords = gem2.coords
	gem2.coords = temp
	yield(get_tree(), "idle_frame")
	match_gems()


func match_gems():
	for x in range(width):
		for y in range(height):
			var gem = find_gem(Vector2(x, y))
			if gem.check_matches():
				print("You win! (%d, %d)" % [x, y])


func _on_gem_selected(gem) -> void:
	gem.set_highlight(selected == null)
	if selected == null:
		gem.set_highlight(true)
		selected = gem
	else:
		selected.set_highlight(false)
		try_swap(selected, gem)
		selected = null
