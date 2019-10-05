extends Node2D

export(int, 3, 12) var height = 3
export(int, 3, 12) var width = 3

const Gem = preload("res://Grid/Gem/Gem.tscn")
enum Matches { Horizontal = 1, Vertical = 2}

const GemTextures = [
		preload("res://Grid/Gem/Shape1.tres"),
		preload("res://Grid/Gem/Shape2.tres"),
		preload("res://Grid/Gem/Shape3.tres")
	]

var selected = null
var gem_count = 9

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


func match_gems() -> void:
	# Collect match information
	var matches = []
	for gem in get_children():
		var match_info = gem.check_matches()
		if match_info != 0:
			matches.push_back([gem.coords, match_info])
	if matches.empty():
		return

	# Remove matched gems
	for m in matches:
		var coords = [ m[0] ]
		if m[1] & Matches.Vertical:
			coords.push_back( m[0] - Vector2(0, 1) )
			coords.push_back( m[0] + Vector2(0, 1) )
		if m[1] & Matches.Horizontal:
			coords.push_back( m[0] - Vector2(1, 0) )
			coords.push_back( m[0] + Vector2(1, 0) )
		for c in coords:
			var gem = find_gem(c)
			if gem != null:
				gem.queue_free()

	# Update remaining grid contents
	yield(get_tree(), "idle_frame")
	update_grid_contents()


func update_grid_contents() -> void:
	for x in range(width):
		for y in range(height - 1, -1, -1):
			var gem = find_gem( Vector2(x, y) )
			if gem != null:
				continue
			var above = null
			for y2 in range(y-1, 0, -1):
				above = find_gem( Vector2(x, y2) )
				if above != null:
					break
			if above != null:
				above.coords = Vector2(x, y)
			else:
				spawn_gem( Vector2(x, y) )


func spawn_gem( coords: Vector2) -> void:
	var gem = Gem.instance()
	gem_count += 1
	gem.set_name("Gem%d" % gem_count)
	gem.type = floor(rand_range(0, 3))
	gem.texture = GemTextures[gem.type]
	gem.coords = coords
	gem.connect("gem_selected", self, "_on_gem_selected")
	add_child(gem)

func _on_gem_selected(gem) -> void:
	gem.set_highlight(selected == null)
	if selected == null:
		gem.set_highlight(true)
		selected = gem
	else:
		selected.set_highlight(false)
		try_swap(selected, gem)
		selected = null


func _ready() -> void:
	randomize()