extends StaticBody2D
var shrinkSize = -5
var shrinkSpeed = 5
func _physics_process(delta: float) -> void:
	if(self.scale.y <= 0 || self.scale.x <= 0):
		queue_free()

func _ready() -> void:
	GlobalVariables.player.power_up_touched.connect(on_adjust_ground)
	if self.is_in_group("side"):
		self.scale.y = 30
	if self.is_in_group("top"):
		self.scale.x = 30
	on_adjust_ground(shrinkSize)


func on_adjust_ground(modifier):
	var tween = create_tween()
	if(self.is_in_group("side")):
		tween.tween_property(self, "scale", Vector2(self.scale.x,self.scale.y + modifier), shrinkSpeed)
	else:	
		tween.tween_property(self, "scale", Vector2(self.scale.x + modifier,self.scale.y), shrinkSpeed)
	await get_tree().create_timer(shrinkSpeed).timeout
	if(modifier < 0):
		on_adjust_ground(modifier)
