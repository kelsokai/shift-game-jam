extends RigidBody2D
var damage = 5
var velocity = 200
	
func _physics_process(delta: float) -> void:
	gravity_scale = 0
	move_and_collide(transform.x * delta * velocity)

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	queue_free()

func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("enemy")):
		body.hit(damage)
		queue_free()# Replace with function body.
