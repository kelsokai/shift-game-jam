extends StaticBody2D

func _physics_process(delta: float) -> void:
	adjust_ground(-0.1)
	pass
	
func _ready() -> void:
	self.scale.x = 85
	
func adjust_ground(modifier):
	self.scale.x += modifier
	if(self.scale.x <= 0):
		queue_free()
