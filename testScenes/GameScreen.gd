extends Node2D

const ICON_SIZE : int = 128

var levels = [Vector2(3,3), 
				Vector2(5,5), 
				Vector2(5,4),
				Vector2(4,5),
				Vector2(4,4),
				Vector2(5,5),
				Vector2(6,6)]
				
var puzzles = [preload("res://Grid/Puzzles/Tutorial.gd"), null, null, null, null, null, null]

func _ready():
	center_grid_on_current_position()
	pass

func center_grid_on_current_position():
	var moveX = -1 * ($Grid.width * (ICON_SIZE / 2))
	var moveY = -1 * ($Grid.height * (ICON_SIZE / 2))
	$Grid.position = Vector2(moveX, moveY)

func load_level(level : int):
	$Grid.load_level(levels[level].x, levels[level].y, puzzles[level])
	center_grid_on_current_position()

func _on_Grid_size_changed() -> void:
	center_grid_on_current_position()