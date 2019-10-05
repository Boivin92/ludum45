extends Node2D

const ICON_SIZE : int = 128

func _ready():
	center_grid_on_current_position()
	pass

func center_grid_on_current_position():
	var moveX = -1 * ($Grid.width * (ICON_SIZE / 2))
	var moveY = -1 * ($Grid.height * (ICON_SIZE / 2))
	$Grid.position = Vector2(moveX, moveY)