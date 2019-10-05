extends "base.gd"

func _init(value, expected: String) -> void:
	self.success = value is PoolIntArray
	self.expected = expected
	self.result = "%s is %s built in: PoolIntArray" % [str(value), "" if self.success else "not"]