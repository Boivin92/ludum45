extends "base.gd"

func _init(value, expected: String) -> void:
	self.success = value is PoolColorArray
	self.expected = expected
	self.result = "%s is %s built in: PoolColorArray" % [str(value), "" if self.success else "not"]