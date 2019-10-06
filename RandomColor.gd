class_name RandomColorGenerator

func Generate():
	randomize()
	var r = rand_range(0,1)
	var g = rand_range(0,1)
	var b = rand_range(0,1)
	return Color(r,g,b)