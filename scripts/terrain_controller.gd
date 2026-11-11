extends StaticBody2D

func _physics_process(delta: float) -> void:
	#adjust_ground(-0.1)
	pass

func adjust_ground(modifier):
	print(self.position)
	self.scale.x += modifier
