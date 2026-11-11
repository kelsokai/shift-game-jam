extends Node2D
@export var enemy_scene: PackedScene
@export var power_up_scene:PackedScene
var score
func _ready() -> void:
	GlobalVariables.new_game()
	$SpawnerTimer.start()
	$PowerUpTimer.start()
	
func _on_spawner_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()

	var mob_spawn_location = Vector2($Player.global_position.x + 200, $Player.global_position.y -200)
	
	enemy.position = mob_spawn_location
	
	add_child(enemy)
	
func _physics_process(delta: float) -> void:
	if(not GlobalVariables.player):
		GlobalVariables.game_over()
		$SpawnerTimer.stop()
		$PowerUpTimer.stop()

func _on_power_up_timer_timeout() -> void:
	var power_up = power_up_scene.instantiate()
	var power_up_spawn_location = Vector2(randf_range($Player.global_position.x - 50, $Player.global_position.x + 50), $Player.global_position.y)
	
	power_up.position = power_up_spawn_location
	add_child(power_up)
	$PowerUpTimer.wait_time = randf_range(5,15)
	




func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		GlobalVariables.health=0
		print(GlobalVariables.health)
	else:
		body.queue_free()
