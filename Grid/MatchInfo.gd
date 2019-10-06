class_name MatchInfo

enum Types { None, Feather, Flower, Hourglass, Book, Gear }

var count := 0
var cascade := 0
var types := []

func add_match(type: int) -> void:
	types.push_back(type)
	count += 1


func clear_matches() -> void:
	count = 0
	types.clear()


func has_type(type: int) -> bool:
	return types.find(type) != -1


func count_type(type: int) -> int:
	return types.count(type)