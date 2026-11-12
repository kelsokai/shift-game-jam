extends Area2D
@export var bullet_scene: PackedScene

func _ready() -> void:
	$Timer.start()
	var mouseCast = $RayCast2D

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	 

func _on_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()

	var bullet_spawn_location = Vector2(self.position.x, self.position.y)
	bullet.global_rotation = self.global_rotation
	bullet.global_position = bullet_spawn_location
	
	get_parent().add_child(bullet)
	
