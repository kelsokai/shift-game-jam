extends Control
var heartPNG = preload("res://resources/heart.png")



func _process(delta: float) -> void:
	for i in $Health.get_child_count():
		$Health.get_child(i).visible = GlobalVariables.health > i	
	$Score.text = "Score: " + str(GlobalVariables.score)
