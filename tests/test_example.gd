extends WATTest

func start(): #ClassInitialize
	pass
	
func pre(): #TestInitialize
	pass

func test_Un_plus_un_egal_deux():
	var result = 1+1
	expect.is_equal(result, 2, "Parce que c'est des maths de base")
	
func post(): #TestCleanup
	pass
	
func end(): #ClassCleanup
	pass