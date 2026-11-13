extends Node2D
@export var enemy_scene: PackedScene
@export var power_up_scene:PackedScene
func _ready() -> void:
	GlobalVariables.new_game()
	$SpawnerTimer.start()
	$PowerUpTimer.start()
	$"Game Over".hide()
	
	
func _on_spawner_timer_timeout() -> void:
	var mob_spawn_location=$Player.global_position
	var enemy = enemy_scene.instantiate()
	if(GlobalVariables.gravity == 0 or GlobalVariables.gravity == 2):
		while mob_spawn_location.x > $Player.global_position.x -50 and mob_spawn_location.x < $Player.global_position.x + 50:
			mob_spawn_location = Vector2($Player.global_position.x + randf_range(-200, 200), $Player.global_position.y)
	else:
		while mob_spawn_location.y > $Player.global_position.y -50 and mob_spawn_location.y < $Player.global_position.y + 50:
			mob_spawn_location = Vector2($Player.global_position.x, $Player.global_position.y + randf_range(-200, 200))
	enemy.position = mob_spawn_location
	add_child(enemy)
	$SpawnerTimer.wait_time = randf_range(1, 5)
	
func _physics_process(delta: float) -> void:
	if(not GlobalVariables.player):
		GlobalVariables.game_over()
		$SpawnerTimer.stop()
		$PowerUpTimer.stop()
		$ScoreTimer.stop()
		$"Game Over/RichTextLabel".text = "score:" + str(GlobalVariables.score)
		$"Game Over".show()

func _on_power_up_timer_timeout() -> void:
	var power_up = power_up_scene.instantiate()
	var power_up_spawn_location = $Player.global_position
	if(GlobalVariables.gravity == 0 or GlobalVariables.gravity == 2):
		while power_up_spawn_location.x > $Player.global_position.x -20 and power_up_spawn_location.x < $Player.global_position.x + 20:
			power_up_spawn_location=Vector2($Player.global_position.x + randf_range(-60, 60), $Player.global_position.y)
	else:
		while power_up_spawn_location.y > $Player.global_position.y -20 and power_up_spawn_location.y < $Player.global_position.y + 20:
			power_up_spawn_location=Vector2($Player.global_position.x, $Player.global_position.y + randf_range(-60, 60))
	
	power_up.global_position = power_up_spawn_location
	add_child(power_up)
	$PowerUpTimer.wait_time = randf_range(8,15)
	




func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		GlobalVariables.health=0
	elif (body.is_in_group("ground")):
		pass
	else:
		body.queue_free()


func _on_score_timer_timeout() -> void:
	GlobalVariables.score += 10 # Replace with function body.
