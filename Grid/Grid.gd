tool

extends Node2D

export(int, 3, 12) var height := 3
export(int, 3, 12) var width := 3
export(bool) var puzzle_mode := false
export(Resource) var puzzle_data

signal matched(match_info)
signal cascade_finished

const Gem = preload("res://Grid/Gem/Gem.tscn")
enum FallTypes { Regular, Spawn }
const GemTextures = [
		preload("res://Grid/Gem/Empty.png"),
		preload("res://Grid/Gem/Feather.tres"),
		preload("res://Grid/Gem/Flower.tres"),
		preload("res://Grid/Gem/Hourglass.tres"),
		preload("res://Grid/Gem/Book.tres"),
		preload("res://Grid/Gem/Gear.tres")
	]

var selected = null
var gem_count := 0
var actions_locked := false
var silent := false


func can_swap(coord1: Vector2, coord2: Vector2) -> bool:
	if selected == null:
		return false
	var delta = (coord1 - coord2).abs()
	var distance_ortho = delta.x + delta.y
	return distance_ortho == 1


func try_swap(gem1, gem2) -> void:
	var coords1 = gem1.coords
	var coords2 = gem2.coords
	if not can_swap(coords1, coords2):
		return
	gem1.move_to(coords2, $Tween)
	gem2.move_to(coords1, $Tween)
	actions_locked = true
	$Tween.start()
	yield($Tween, "tween_all_completed")
	actions_locked = false
	match_gems(MatchInfo.new())


func match_gems(match_info: MatchInfo) -> void:
	# Check for matched gems
	for gem in $GemContainer.get_children():
		if gem.check_matches():
			match_info.add_match(gem.type)

	# Remove matched gems
	for gem in $GemContainer.get_children():
		if gem.to_remove:
			if puzzle_mode and not puzzle_data.gravity:
				gem.type = MatchInfo.Types.None
				gem.texture = GemTextures[0]
			else:
				gem.queue_free()

	# Update remaining grid contents
	if match_info.count > 0:
		if not silent:
			emit_signal("matched", match_info)
		yield(get_tree(), "idle_frame")
		update_grid_contents(match_info)
	else:
		# Has to be here because of all the yield()-ing
		if not silent:
			emit_signal("cascade_finished")
		silent = false


func update_grid_contents(match_info: MatchInfo) -> void:
	# Init update logic variables
	var gems = $GemContainer.get_children()
	gems.sort_custom(self, "sort_update_order")
	var column := 0
	var gem_column_count := 0

	# General algorithm
	for gem in gems:
		if gem.coords.x != column:
			# Spawn gems for previous column
			spawn_column_gems(column, height - gem_column_count)
			# Spawn gems for any skipped column
			for col in range(column + 1, gem.coords.x):
				spawn_column_gems(col, height)
			# Reset fall logic data for new column
			column = gem.coords.x
			gem_column_count = 0
		gem_column_count += 1
		gem.set_fall(height - gem_column_count - gem.coords.y, FallTypes.Regular, $Tween)

	# Repeat spawn logic for empty last column(s)
	spawn_column_gems(column, height - gem_column_count)
	for col in range(column + 1, width):
		spawn_column_gems(col, height)

	# All required data computed, now to animate
	actions_locked = true
	$Tween.start()
	yield($Tween, "tween_all_completed")
	match_info.cascade += 1
	match_info.clear_matches()
	match_gems(match_info)
	actions_locked = false


func sort_update_order(gem1, gem2) -> bool:
	if gem1.coords.x == gem2.coords.x:
		return gem1.coords.y > gem2.coords.y
	return gem1.coords.x < gem2.coords.x


func spawn_column_gems(column: int, fall_distance: int) -> void:
	for y in range(-1, -1 - fall_distance, -1):
		spawn_gem_at(Vector2(column, y), fall_distance)


func spawn_gem_at(coord: Vector2, fall_distance: int, type: int = -1):
	var gem = Gem.instance()
	gem_count += 1
	gem.set_name("Gem%d" % gem_count)
	if type < 0:
		gem.type = floor(rand_range(1, 5))
	else:
		gem.type = type
	gem.texture = GemTextures[gem.type]
	gem.coords = coord
	gem.connect("gem_selected", self, "_on_gem_selected")
	if fall_distance > 0:
		gem.set_fall(fall_distance, FallTypes.Spawn, $Tween)
	$GemContainer.add_child(gem)

func _on_gem_selected(gem) -> void:
	if actions_locked:
		return
	if selected == null and gem.type != MatchInfo.Types.None:
		gem.set_highlight(true)
		selected = gem
	elif selected != null:
		selected.set_highlight(false)
		try_swap(selected, gem)
		selected = null


func _ready() -> void:
	if puzzle_mode:
		load_puzzle_data()
	else:
		randomize()
		reset_grid()


func load_puzzle_data():
	var x := 0
	for column in puzzle_data.columns:
		for i in range(height):
			var type = MatchInfo.Types.None
			if i < column.size():
				type = column[i]
			spawn_gem_at(Vector2(x, height - i - 1), -1, type)
		x += 1


func reset_grid():
	silent = true
	for gem in $GemContainer.get_children():
		gem.queue_free()
	yield(get_tree(), "idle_frame")
	update_grid_contents(MatchInfo.new())


func _get_configuration_warning() -> String:
	if puzzle_mode:
		if not puzzle_data:
			return "Grid set to puzzle mode does not have puzzle data"
	return ""
