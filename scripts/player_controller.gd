extends CharacterBody2D




const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_shift = 2

func _ready() -> void:
	GlobalVariables.player = self
	
func _physics_process(delta: float) -> void:
	
	#kill player
	if GlobalVariables.health <= 0:
		queue_free()
		
	
	# Add the gravity.
	if Input.is_action_just_pressed("rotate_left") and can_shift != 0:
		can_shift -= 1
		rotation_degrees += 90 
		if GlobalVariables.gravity == 0:
			GlobalVariables.gravity = 3
		else:
			GlobalVariables.gravity -= 1

	#if Input.is_action_just_pressed("rotate_right") and can_shift:
		#can_shift = false
		#$Camera2D.rotation_degrees -= 90
		#rotation_degrees  -= 90
		#if gravity == 3:
			#gravity = 0
		#else:
			#gravity +=1

	#determines gravity direction
	flip_gravity()
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() :
		match GlobalVariables.gravity:
			0:
				velocity.y = JUMP_VELOCITY
			1:
				velocity.x = JUMP_VELOCITY
			2:
				velocity.y = -JUMP_VELOCITY
			3:
				velocity.x = -JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	move(direction)

	move_and_slide()
	
	var collision = get_last_slide_collision()
	if(collision and collision.get_collider().is_in_group("powerup")):
		print("extend")
a		Terrain.adjust_ground(5)
		collision.get_collider().queue_free()
	
	if is_on_floor(): can_shift = 2


func move(direction):
	match GlobalVariables.gravity:
		0:
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
		1:
			if direction:
				velocity.y = -direction * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
		2:
			if direction:
				velocity.x = -direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
		3:	
			if direction:
				velocity.y = direction * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
func flip_gravity():
	match GlobalVariables.gravity:
		0: 
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
			up_direction = Vector2.UP
		1:
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.RIGHT)
			up_direction = Vector2.LEFT
		2:
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.UP)
			up_direction = Vector2.DOWN
		3:
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.LEFT)
			up_direction = Vector2.RIGHT
			
func hit(damage):
	if(not GlobalVariables.invulnerable):
		GlobalVariables.health -= damage
		GlobalVariables.invulnerable= true
		await get_tree().create_timer(1.0).timeout
		GlobalVariables.invulnerable = false
	
